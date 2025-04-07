import ReactDOM from 'react-dom/client'
import { useState, useEffect, useRef } from 'react'
import {
  DataGridPremium as DataGrid,
  GridToolbarContainer,
  GridToolbarExportContainer,
  GridExcelExportMenuItem,
  useGridApiRef
} from '@mui/x-data-grid-premium'

// ICONS
import DataObjectIcon from '@mui/icons-material/DataObject'

import { Button } from '@mui/material'
import { LicenseInfo } from '@mui/x-license-pro'
import useOptionsStore from 'src/store/apps/konfigurator/optionsStore'
import { PDFDownloadLink } from '@react-pdf/renderer'
import DatenblattBiro40 from './datenblatt'
import DeleteForeverIcon from '@mui/icons-material/DeleteForever'
import TextSnippetIcon from '@mui/icons-material/TextSnippet'
import LightConfigurator from './datenblatt/LightConfigurator'

LicenseInfo.setLicenseKey(
  '9976d97acf87adbea97cc4c765980c8cTz05ODk1NixFPTE3NTkwNDQ5MDQwMDAsUz1wcmVtaXVtLExNPXN1YnNjcmlwdGlvbixQVj1pbml0aWFsLEtWPTI='
)

const currencyFormatter = new Intl.NumberFormat('de-DE', {
  style: 'currency',
  currency: 'EUR',
  minimumFractionDigits: 2,
  maximumFractionDigits: 3
})

const kep = {
  KEP_ID: '7411152',
  FIGUR_POS: 4,
  FIGUR: 'FIGUR Z',
  FIGUR_INDEX: 'Z',
  PRODUKT_ID: 74,
  KEP_PRO_INDEX: 11,
  KEP_GTR_INDEX: 15,
  KEP_OPT_INDEX: 2,
  HERSTELLER: 'BRUMBERG',
  PRODUKT: 'BIRO40',
  LICHTRICHTUNG: 'DIREKT INDIREKT',
  SCHUTZART: 'IP20',
  GEHAEUSEFARBE: 'WEISS',
  MONTAGEART: 'EINBAU',
  MONTAGEART_KEP: 'EINBAU',
  LICHTFARBE: '6500 K',
  LICHTFARBE_DIREKT: '6.500 K',
  LICHTFARBE_INDIREKT: 'RGBW',
  LICHTSTROM: 'HIGH OUTPUT',
  CRI: 'RA>90',
  ANSTEUERUNG: 'SCHALTBAR',
  POLE: '3 POL',
  OPTISCHES_SYSTEM: 'PRISMATISCH',
  MIN: 840,
  PROFIL_TYP: 'PROFIL ANBAU',
  PRO_BASE_ID: '74P011',
  LICHTEINSATZ_TYP: 'LICHTEINSATZ',
  GTR_BASE_ID: '74G1603',
  OPTIK_TYP: 'OPTIK',
  OPT_BASE_ID: '74OP20',
  ENDDECKEL_TYP: 'ENDDECKEL',
  KSED_ID: '74PZK01100',
  VERBINDER_TYP: 'VERBINDER',
  VERB_ID: '74PZV01100',
  BEFESTIGUNGS_TYP: 'KEINE',
  BEFE_ID: 'KEINE',
  EINSPEISER_TYP: 'KEINE',
  ESPE_ID: 'KEINE',
  EULUM: 'DIREKT 6500 K RA>90 PRISMATISCH',
  BERECHNUNGSLAENGE: 1000,
  LUMEN_M_DIREKT: 0,
  LUMEN_M_INDIREKT: 0,
  LUMEN_M_GESAMT: 2400,
  LEISTUNG_M_GESAMT: 40,
  LUMEN_PRO_WATT_M: 0,
  EULUMDAT_BASIS: 'DIREKT_RA90_PRISMATISCH_1000.LDT',
  HEADERBILD: 'Z_ANBAU_W.jpg',
  PRODUKTBILD: 'ANBAU_DI_PRISMATISCH_6500K_NULL_WEISS.jpg',
  SKIZZE: 'FIGUR_Z.png',
  POLARDIAGRAMM: 'DIREKT_6500_K_null_PRISMATISCH.jpg',
  SVG_IMAGE: 'SVG_7411152.svg',
  SSC_INPUT_1: '#SSC!_*INPUT1#',
  SSC_INPUT_2: '#SSC!_*INPUT2#',
  SSC_INPUT_3: '#SSC!_*INPUT3#',
  SSC_INPUT_4: '#SSC!_*INPUT4#',
  SSC_INPUT_5: '#SSC!_*INPUT5#',
  SSC_INPUT_6: '#SSC!_*INPUT6#',
  SSC_INPUT_7: '#SSC!_*INPUT7#',
  SSC_INPUT_8: '#SSC!_*INPUT8#',
  SSC_INPUT_9: '#SSC!_*INPUT9#',
  SSC_INPUT_10: '#SSC!_*INPUT10#!*SCHALTBAR',
  KURZBESCHREIBUNG: 'LED-Profilsystem Anbau direkt strahlend',
  MATERIAL: 'Aluminium / Acryl',
  FARBE: 'weiss',
  PROFILQUERSCHNITT: '40mm x 75mm',
  NETTOGEWICHT_M: 2.281,
  KONFORMITAET: 'CE, UKCA',
  FARBTEMPERATUR_DIREKT: '6.500 K',
  FARBTEMPERATUR_INDIREKT: 'RGBW',
  LICHTFARBE_FT: 'tageslichtweiss',
  FARBTOLERANZ: 'McAdam-Step 3',
  FARBWIEDERGABE: 'CRI > 90',
  LEUCHTENOPTIK: 'Abdeckung mikroprismatisch',
  REFLEKTOR: 'Ohne',
  ABSTRAHLWINKEL: '80°',
  BLENDUNGSBEWERTUNG: 'UGR < 19',
  LICHTVERTEILUNG: 'symmetrisch',
  FARBTEMPERATUR_EINSTELLBAR: 'Nein',
  SPANNUNGSART: 'AC',
  AC_NENNSPANNUNG: '230 V',
  FREQUENZ: '50 Hz',
  LEUCHTMITTEL: 'LED',
  SCHUTZKLASSE: 'I',
  SCHUTZART_RAUMSEITIG: 'IP20',
  LEBENSDAUER_L70B50_25: '60.000 h',
  LEBENSDAUER_L80B50_25: '60.000 h',
  DIMMBAR: 'nein',
  DIM_ANSTEUERUNG: 'schaltbar on/off',
  ANZAHL_VG_LICHTEINSATZ: 1,
  BASISTEXT:
    'Modulares LED-Profilleuchtensystem BIRO40 direkt strahlend, geeignet für die Decken- oder Wandaufbaumontage. System bestehend aus stranggepresstem Aluminiumprofil, Lichteinsätzen, Leuchtenoptiken und allem notwendigen Systemzubehör wie Enddekkappen und Profilverbinder. (Gesonderte Befestigungen entfallen bei der Anbauvariante.) Versetzte Form mit zwei Richtungswechseln, oft eingesetzt zur Überbrückung von Versprüngen in Decken- oder Wandbereichen (Figur in Form eines Z).',
  ERWEITERTER_TEXT:
    'Material: Aluminium / Acryl, Systemvariante: LED-Profilsystem Anbau direkt strahlend, Gehaeusefarbe: weiss, Profilquerschnitt: 40mm x 75mm, Leuchtenoptik: Abdeckung mikroprismatisch, Lichtaustritt: direkt, Abstrahlwinkel: 80°, Lichtverteilung: symmetrisch, Lichtfarbe: tageslichtweiss, Farbtemperatur direkt: 6.500 K, Farbtoleranz: McAdam-Step 3, Farbwiedergabeindex: CRI > 90, Blendbewertung: UGR < 19, Ansteuerung: schaltbar on/off, Leuchtmittel: LED, Betriebsspannung: 230 V AC 50 Hz, Schutzklasse: I, Schutzart: IP20, Lebensdauer L70 B50 bei 25C: 60.000 h, Lebensdauer L80 B50 bei 25C: 60.000 h, Effizienz: 0 lm/W',
  GROUP: '7411152-Z',
  BEFESTIGUNGSABSTAND_ABZUG: 300,
  BEFESTIGUNGSABSTAND_MAX: 1500,
  ESP_VERSATZ: 50,
  STROKE_FAKTOR: 1.4,
  STROKE_COLOR: 'black',
  STROKE_FILL: 'Seashell',
  DECKENAUSSCHNITT_BREITE: 45,
  DECKENAUSSCHNITT_TOLERANZ: 5,
  EINBAUTIEFE_MIN: 110,
  INSTALLATIONSTYP: 'Pendelausführung mittels höhenverstellbarer Stahlseile (max. 3,0 m)'
}

const TableDataGridBiro40 = props => {
  const { output, biro_konfiguration, setBiroKonfiguration, deleteBiroKonfiguration, getChoice } = useOptionsStore()
  const apiRef = useGridApiRef()
  const itemSortOrder = ['PROFIL', 'LICHTEINSATZ', 'OPTIK', 'BEFESTIGUNG', 'VERBINDER', 'EINSPEISER', 'ENDDECKEL']
  const konfigurationsCounter = useRef(0)
  // functions
  const itemSortComparator = (a, b) => {
    const indexA = itemSortOrder.indexOf(a)
    const indexB = itemSortOrder.indexOf(b)

    if (indexA === -1 && indexB === -1) return 0 // Falls beide nicht in der Liste sind, bleibt die Reihenfolge gleich
    if (indexA === -1) return 1 // Falls A nicht in der Liste ist, soll B davor stehen
    if (indexB === -1) return -1 // Falls B nicht in der Liste ist, soll A davor stehen

    return indexA - indexB // Sortierung nach benutzerdefiniertem Index
  }

  const aggregateRows = data => {
    const aggregatedData = []
    Object.keys(data).forEach(key => {
      data[key].forEach(artikel => {
        aggregatedData.push({
          ...artikel,
          KONFIGURATIONID: key,
          ME: parseInt(artikel.ME, 10)
        })
      })
    })
    return aggregatedData
  }

  const handleJSONDownload = id => {
    const aggregatedData = aggregateRows(biro_konfiguration)
    const gefiltert = aggregatedData.filter(item => item.KONFIGURATIONID === id)

    const jsonString = JSON.stringify(gefiltert, null, 2)
    const blob = new Blob([jsonString], { type: 'application/json' })
    const link = document.createElement('a')
    link.href = URL.createObjectURL(blob)
    link.download = `${id}.json`
    link.click()
  }

  const exportAggregatedJSON = () => {
    const aggregatedData = aggregateRows(biro_konfiguration)
    const jsonString = JSON.stringify(aggregatedData, null, 2)
    const blob = new Blob([jsonString], { type: 'application/json' })
    const link = document.createElement('a')
    link.href = URL.createObjectURL(blob)
    link.download = 'Aggregierte_Daten.json'
    link.click()
  }

  // Welche Spalten sollen ausgeblendet werden können?
  const [columnVisibilityModel, setColumnVisibilityModel] = useState({
    KONFIGURATION: false,
    TYP: false,
    SCHENKEL: false,
    ITEMID: false,
    KONFIGURATIONID: false,
    EULUM: false

    // Weitere Spalten, die du ausblenden möchtest
  })

  //
  const handleOpenDatenblatt = id => {
    console.log('Öffne Datenblatt für Konfiguration:', id)

    const newWindow = window.open('', '_blank')
    newWindow.document.write(`
      <!DOCTYPE html>
      <html>
        <head>
          <title>Datenblatt Konfiguration ${id}</title>
          <meta charset="UTF-8" />
          <style>
            body { margin: 0; font-family: Arial, sans-serif; }
          </style>
        </head>
        <body>
          <div id="light-configurator-root"></div>
        </body>
      </html>
    `)
    newWindow.document.close()
    ReactDOM.createRoot(newWindow.document.getElementById('light-configurator-root')).render(
      <LightConfigurator id={id} kep={kep} />
    )
  }

  const columns = [
    { field: 'KONFIGURATIONID', headerName: 'KONFIGURATIONS_ID', flex: 1 },
    { field: 'ITEMID', headerName: 'ITEM_ID', flex: 1 },
    { field: 'KONFIGURATION', headerName: 'KONFIGURATION', width: 300, hide: true },
    { field: 'SYSTEMMASS', headerName: 'SYSTEMMASS', flex: 1 },
    { field: 'LV_POSITION', headerName: 'LV POSITION', flex: 1 },
    { field: 'FIGUR', headerName: 'FIGUR', flex: 1, groupable: false },
    { field: 'SCHENKEL', headerName: 'SCHENKEL', flex: 1 },
    { field: 'ITEM', headerName: 'ITEM', flex: 1, sortComparator: itemSortComparator },
    { field: 'TYP', headerName: 'TYP', flex: 1, groupable: false },
    { field: 'ME', headerName: 'MENGE', flex: 1 },
    { field: 'ARTIKELNUMMER', headerName: 'ARTIKELNUMMER', flex: 1 },
    { field: 'BESCHREIBUNG', headerName: 'BESCHREIBUNG', flex: 1 },
    {
      field: 'PREIS',
      headerName: 'PREIS',
      flex: 1,
      valueFormatter: ({ value }) => (value ? currencyFormatter.format(value) : value)
    },
    {
      field: 'Gesamtpreis',
      headerName: 'Gesamtpreis',
      flex: 1,
      type: 'number',
      aggregation: 'sum',
      valueGetter: params => {
        if (!params.row.PREIS || !params.row.ME) {
          return null
        }
        return parseFloat(params.row.PREIS) * parseInt(params.row.ME)
      },
      valueFormatter: ({ value }) => (value ? currencyFormatter.format(value) : null)
    },
    {
      field: 'datenblatt',
      headerName: 'Datenblatt',
      width: 100,
      sortable: false,
      filterable: false,
      renderCell: params => {
        if (params.rowNode.groupingField === 'KONFIGURATIONID') {
          const dataForKey = biro_konfiguration[params.rowNode.groupingKey]
          const configID = dataForKey.map(item => item.KONFIGURATION)
          return (
            <Button
              variant='contained'
              color='secondary'
              sx={{
                fontSize: '10px',
                borderRadius: '50%',
                width: 32,
                height: 32,
                minWidth: 0,
                padding: 0
              }}
              size='small'
              onClick={() => handleOpenDatenblatt(configID[0])}
            >
              <TextSnippetIcon fontSize='small' />
            </Button>
          )
        }
        return null
      }
    },
    {
      field: 'JSON',
      headerName: 'JSON',
      hide: true,
      // flex: 1,
      width: 100,
      sortable: false,
      filterable: false,
      renderCell: params => {
        // Prüft, ob es sich um eine Gruppenzeile handelt
        if (params.rowNode.groupingField === 'KONFIGURATIONID') {
          return (
            <Button
              variant='contained'
              sx={{
                fontSize: '10px',
                borderRadius: '50%', // rund
                width: 32, // gleiche Breite und Höhe
                height: 32,
                minWidth: 0, // verhindert zusätzliche Mindestbreite
                padding: 0 // falls du den Innenabstand reduzieren möchtest
              }}
              size='small'
              color='secondary'
              onClick={() => handleJSONDownload(params.rowNode.groupingKey)}
            >
              <DataObjectIcon fontSize='small' />
            </Button>
          )
        }
        return null
      }
    },
    {
      field: 'deleteConfig',
      headerName: 'Löschen',
      // flex: 1,
      width: 100,
      sortable: false,
      filterable: false,
      renderCell: params => {
        // Prüfen, ob es sich um eine Gruppenzeile auf Ebene "KONFIGURATION" handelt:
        if (params.rowNode.groupingField === 'KONFIGURATIONID') {
          // groupingKey enthält den Wert der Gruppierung, hier also die KONFIGURATION
          const configurationKey = params.rowNode.groupingKey

          return (
            <Button
              variant='contained'
              sx={{
                fontSize: '10px',
                borderRadius: '50%', // rund
                width: 32, // gleiche Breite und Höhe
                height: 32,
                minWidth: 0, // verhindert zusätzliche Mindestbreite
                padding: 0 // falls du den Innenabstand reduzieren möchtest
              }}
              size='small'
              color='error'
              onClick={() => handleDeleteConfiguration(configurationKey)}
            >
              <DeleteForeverIcon fontSize='small' />
            </Button>
          )
        }
        return null
      }
    }
  ]

  useEffect(() => {
    let configCounter = konfigurationsCounter.current

    if (Array.isArray(output) && output.length > 0) {
      const fetchDetailsForIds = async () => {
        try {
          const artikelMap = { ...biro_konfiguration }
          let positionCounter = 1
          await Promise.all(
            output.map(async item => {
              try {
                const response = await fetch(`/api/biro40/getArtikel?id=${item.ID}`)
                const result = await response.json()

                if (result && result.length > 0) {
                  const artikel = {
                    LV_POSITION: getChoice('lv_position'),
                    ITEMID: positionCounter++,
                    KONFIGURATION: item.KONFIGURATION,
                    SYSTEMMASS: item.SYSTEMMASS,
                    FIGUR: item.FIGUR,
                    SCHENKEL: 'SCHENKEL ' + item.SCHENKEL,
                    ITEM: item.ITEM,
                    TYP: item.TYP,
                    ME: item.ME,
                    ARTIKELNUMMER: result[0].artikelnummer,
                    KURZTEXT: result[0].kurztext,
                    BESCHREIBUNG: result[0].beschreibung,
                    PREIS: result[0].preis
                  }

                  if (!artikelMap['Konfiguration-' + configCounter]) {
                    artikelMap['Konfiguration-' + configCounter] = []
                  }

                  artikelMap['Konfiguration-' + configCounter].push(artikel)
                }
              } catch (error) {
                console.error(`Error fetching details for ID ${item.ID}:`, error)
              }
            })
          )
          konfigurationsCounter.current++
          setBiroKonfiguration(artikelMap)
        } catch (error) {
          console.error('Fehler beim Abrufen der Artikeldaten:', error)
        }
      }

      fetchDetailsForIds()
    }
  }, [props.refreshKey])

  const CustomToolbar = () => (
    <GridToolbarContainer>
      <GridToolbarExportContainer>
        <GridExcelExportMenuItem />
      </GridToolbarExportContainer>
      <Button variant='contained' color='primary' onClick={exportAggregatedJSON} style={{ marginLeft: 10 }}>
        JSON-Download
      </Button>
    </GridToolbarContainer>
  )

  // Neue Funktion zum Löschen einer Konfiguration
  const handleDeleteConfiguration = configurationKey => {
    deleteBiroKonfiguration(configurationKey)
  }

  return (
    <div
      style={{
        padding: 10,
        height: '100%',
        width: '100%'
      }}
    >
      <DataGrid
        apiRef={apiRef}
        rows={aggregateRows(biro_konfiguration)}
        columns={columns}
        pageSize={10}
        rowsPerPageOptions={[10]}
        disableRowSelectionOnClick
        groupingColDef={{
          hideDescendantCount: true
        }}
        columnVisibilityModel={columnVisibilityModel}
        onColumnVisibilityModelChange={newModel => setColumnVisibilityModel(newModel)}
        components={{ Toolbar: CustomToolbar }}
        // getRowId={row => row.KONFIGURATIONS_ID} // Hier wird die eindeutige id verwendet.
        getRowId={row => `${row.KONFIGURATIONID}-${row.ITEMID}`}
        sx={{
          height: 'auto',
          width: '100%',
          overflowX: 'auto',
          '& .MuiDataGrid-columnHeaders': {
            backgroundColor: '#f5f5f5',
            fontSize: 14,
            fontWeight: 'bold'
          },
          '& .MuiDataGrid-cell': {
            whiteSpace: 'nowrap'
          }
        }}
        initialState={{
          aggregation: {
            model: {
              Gesamtpreis: 'sum'
            }
          },
          rowGrouping: {
            model: ['LV_POSITION', 'KONFIGURATIONID', 'KONFIGURATION', 'SCHENKEL']
          },
          sorting: {
            sortModel: [
              { field: 'SCHENKEL', sort: 'asc' },
              { field: 'TYP', sort: 'asc' },
              { field: 'ITEM', sort: 'asc' }
            ]
          }
        }}
        experimentalFeatures={{ rowGrouping: true, aggregation: true }}
      />
    </div>
  )
}

export default TableDataGridBiro40
