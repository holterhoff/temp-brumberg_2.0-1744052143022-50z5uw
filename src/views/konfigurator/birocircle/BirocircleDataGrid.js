import * as React from 'react'

import { Box, Button, IconButton } from '@mui/material'
import { DataGridPremium as DataGrid } from '@mui/x-data-grid-premium'

// ** Icon Imports
import Icon from 'src/@core/components/icon'

import { useDispatch, useSelector } from 'react-redux'
import { konfiguratorActions } from 'src/store/apps/konfigurator'

const BirocircleDataGrid = props => {
  // ** Store
  const dispatch = useDispatch()
  const store = useSelector(state => state.konfigurator)
  const flex = store.data.flex

  let rows

  flex.map(data => {
    if (data.id == props.id) {
      rows = data.positions
    }
  })

  const columns = [
    {
      field: 'position',
      headername: 'Position',
      flex: 1
    },
    {
      field: 'bezeichnung',
      headername: 'Bezeichnung',
      flex: 1
    },
    {
      field: 'artikelnummer',
      headername: 'Artikelnummer',
      flex: 1
    },
    {
      field: 'zusatz',
      headername: 'Zusatz',
      flex: 1
    },
    {
      field: 'menge',
      headername: 'Menge',
      flex: 1
    },
    {
      field: 'bp_produkt',
      headername: 'BP-Produkt',
      flex: 1
    },
    {
      field: 'bp_gesamt',
      headername: 'BP-Gesamt',
      flex: 1
    },
    {
      field: 'Delete',
      headername: 'Delete',
      flex: 1,
      renderCell: params => {
        return (
          <IconButton aria-label='delete' color='error'>
            <Icon icon='material-symbols:delete-rounded' onClick={e => onDeleteHandler(params.row, props.id)} />
          </IconButton>
        )
      }
    }
  ]

  // ** Handlers

  const onDeleteHandler = (row, id) => {
    //  const output = data.data.flex.filter(item => item.positions.find(pos => pos.position === 0))

    // const position = {id: props.id, position: row.position}
    dispatch(konfiguratorActions.deletePosition({ konfigId: id, row }))
  }

  return (
    <Box sx={{ height: 520, width: '100%' }}>
      <DataGrid
        getRowId={row => row.id}
        rows={rows}
        columns={columns}
        // rowsPerPageOptions={[5]}
        rowHeight={38}
        checkboxSelection
        disableSelectionOnClick
        experimentalFeatures={{ newEditingApi: true }}
      />
    </Box>
  )
}

export default BirocircleDataGrid
