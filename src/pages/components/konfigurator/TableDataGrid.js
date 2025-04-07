import { useState, useEffect, Fragment } from 'react'
import { useDispatch, useSelector } from 'react-redux'
// ** Material Imports
import { Box, Button, IconButton, Link, MenuItem } from '@mui/material'
import Translations from 'src/layouts/components/Translations'
//** DataGrid Imports
import {
  DataGridPremium as DataGrid,
  GridToolbarExport,
  GridToolbar,
  GridToolbarExportContainer,
  GridPrintExportOptions,
  GridPrintExportMenuItem,
  GridExcelExportMenuItem,
  gridFilteredSortedRowIdsSelector,
  gridVisibleColumnFieldsSelector,
  GridToolbarContainer,
  useGridApiRef,
  useGridApiContext,
  useKeepGroupedColumnsHidden
} from '@mui/x-data-grid-premium'
import { LicenseInfo } from '@mui/x-license-pro'
// ** Store Imports
import { konfiguratorActions } from 'src/store/apps/konfigurator'
// ** PDF
import MyDocument from './TableDataPDF'
import { PDFDownloadLink } from '@react-pdf/renderer'

LicenseInfo.setLicenseKey(
  '9976d97acf87adbea97cc4c765980c8cTz05ODk1NixFPTE3NTkwNDQ5MDQwMDAsUz1wcmVtaXVtLExNPXN1YnNjcmlwdGlvbixQVj1pbml0aWFsLEtWPTI'
)

const currencyFormatter = new Intl.NumberFormat('de-DE', {
  style: 'currency',
  currency: 'EUR',
  minimumFractionDigits: 2,
  maximumFractionDigits: 3
})

const TableDataGrid = props => {
  // ** Store
  const dispatch = useDispatch()
  const store = useSelector(state => state.konfigurator)
  const data = store.data.flex
  const [rows, setRows] = useState([])
  const apiRef = useGridApiRef()
  const initialState = useKeepGroupedColumnsHidden({
    apiRef,
    initialState: {
      rowGrouping: {
        model: ['konfigId', 'Typ']
      },
      aggregation: {
        model: {
          Gesamtpreis: 'sum'
          // Menge: 'sum'
        }
      }
    }
  })
  const columns = [
    {
      field: 'konfigId',
      headerName: 'ID',
      flex: 2
    },
    {
      field: 'Typ',
      headerName: 'Typ',
      flex: 2
    },
    {
      field: 'Bezeichnung',
      headerName: 'Bezeichnung',
      flex: 2,
      groupable: false
    },
    {
      field: 'Menge',
      headerName: 'Menge',
      flex: 1,
      type: 'number',
      groupable: false,
      aggregation: 'sum'
    },
    {
      field: 'Artikelnummer',
      headerName: 'Artikelnummer',
      flex: 1,
      groupable: false
    },
    {
      field: 'Datenblatt',
      headerName: 'Datenblatt',
      flex: 1,
      groupable: false
    },
    {
      field: 'Preis',
      headerName: 'Preis',
      flex: 1,
      type: 'number',
      groupable: false,
      valueFormatter: ({ value }) => {
        if (!value) {
          return value
        }
        return currencyFormatter.format(value)
      }
    },
    {
      field: 'Gesamtpreis',
      headerName: 'Gesamtpreis',
      flex: 1,
      type: 'number',
      groupable: false,
      aggregation: 'sum',
      valueGetter: params => {
        if (!params.row.Preis || !params.row.Menge) {
          return null
        }
        return parseFloat(params.row.Preis) * parseInt(params.row.Menge)
      },
      valueFormatter: ({ value }) => {
        if (!value) {
          return null
        }
        return currencyFormatter.format(value)
      }
    }
  ]

  // Schreibe die Konfigurations-ID auch in jede Position, damit man es gruppieren kann

  const generateRows = () => {
    let rows = []
    let id = 0
    data.forEach(objekt => {
      const positions = objekt.positions.map(position => {
        id++
        return Object.assign({}, position, { konfigId: objekt.id, id: id })
      })
      rows = rows.concat(positions)
    })
    return rows
  }

  useEffect(() => {
    const updatedRows = generateRows()
    setRows(updatedRows)
  }, [data])

  const tableData = { rows, columns }
  // ** Handlers

  const onDeleteHandler = (row, id) => {
    dispatch(konfiguratorActions.deletePosition({ konfigId: id, row }))
  }

  // Definiere die Komponente für das PDF-Dokument

  // Definiere die Komponente für die PDF-Ausgabe zum Drucken
  const PrintPDF = rows => (
    <div>
      <PDFDownloadLink
        document={<MyDocument data={rows} />}
        fileName='Konfiguration.pdf'
        style={{ textDecoration: 'none' }}
      >
        {({ blob, url, loading, error }) =>
          loading ? (
            'Lade PDF herunter...'
          ) : (
            <MenuItem style={{ color: 'rgba(76, 78, 100, 0.87)' }}>Download as PDF</MenuItem>
          )
        }
      </PDFDownloadLink>
    </div>
  )

  const getJson = data => {
    console.log(data)
    // Stringify with some indentation
    // https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#parameters
    return JSON.stringify(data, null, 2)
  }

  const exportBlob = (blob, filename) => {
    // Save the blob in a json file
    const url = URL.createObjectURL(blob)

    const a = document.createElement('a')
    a.href = url
    a.download = filename
    a.click()

    setTimeout(() => {
      URL.revokeObjectURL(url)
    })
  }

  function CustomToolbar(props) {
    return (
      <GridToolbarContainer {...props}>
        {/* <GridToolbarExport /> */}
        <CustomExportButton />
      </GridToolbarContainer>
    )
  }

  function CustomExportButton(props) {
    return (
      <GridToolbarExportContainer {...props}>
        <GridExcelExportMenuItem />
        <MyCustomMenu />
      </GridToolbarExportContainer>
    )
  }

  function MyCustomMenu(props) {
    const { hideMenu } = props

    return (
      <Fragment>
        <MenuItem
          onClick={() => {
            const jsonString = getJson(data)
            const blob = new Blob([jsonString], {
              type: 'text/json'
            })
            exportBlob(blob, 'Konfiguration.json')
            // Hide the export menu after the export
            hideMenu?.()
          }}
        >
          Download as JSON
        </MenuItem>
        {/* Export PDF */}
        <PrintPDF rows={rows}></PrintPDF>
      </Fragment>
    )
  }

  return (
    <div
      style={{
        padding: 10,
        height: 400,
        width: '100%'
      }}
    >
      <DataGrid
        columnHeaderHeight={80}
        autoHeight={true}
        sx={{
          height: 'auto',
          '& .MuiDataGrid-footerCell': { color: 'red', fontWeight: '800' },
          '& .MuiDataGrid-cell:last-of-type': { color: 'red', fontWeight: '300' }
        }}
        {...tableData}
        apiRef={apiRef}
        initialState={initialState}
        disableRowSelectionOnClick
        slots={{ toolbar: CustomToolbar }}
        // getAggregationPosition={groupNode => (groupNode.depth === 1 ? null : 'footer')}
      />
    </div>
  )
}

export default TableDataGrid
