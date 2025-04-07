import * as React from 'react'
import { useEffect } from 'react'

import Accordion from '@mui/material/Accordion'
import AccordionSummary from '@mui/material/AccordionSummary'
import AccordionDetails from '@mui/material/AccordionDetails'
import Typography from '@mui/material/Typography'
import { Box, Button } from '@mui/material'

// ** Icon Imports
import Icon from 'src/@core/components/icon'

import FlexDataGrid from './BirocircleDataGrid'

// ** Store Imports
import { useDispatch, useSelector } from 'react-redux'
import { konfiguratorActions } from 'src/store/apps/konfigurator'

export default function BirocircleTable() {
  // ** Hooks

  const dispatch = useDispatch()
  const store = useSelector(state => state.konfigurator)
  const flex = store.data.flex

  // ** Handlers

  const onDeleteHandler = e => {
    dispatch(konfiguratorActions.deleteKonfig(e.target.value))
  }

  return (
    <Box sx={{ width: '100%', mt: 5 }}>
      {flex.map(data => (
        <Accordion key={data.id}>
          <AccordionSummary
            expandIcon={<Icon icon='mdi:chevron-down' />}
            aria-controls='panel1a-content'
            id='panel1a-header'
          >
            <Typography>Konfiguration-ID: {data.id}</Typography>
          </AccordionSummary>
          <AccordionDetails>
            <Typography>
              <Button onClick={onDeleteHandler} value={data.id} variant='contained' color='error' size='small'>
                Konfiguration löschen
              </Button>
              {/* <StyledLink href={`/konfigurator/datasheet/preview/${data.id}`}>Datenblatt aufrufen</StyledLink> */}
              <FlexDataGrid id={data.id}></FlexDataGrid>
            </Typography>
          </AccordionDetails>
        </Accordion>
      ))}
    </Box>
  )
}
