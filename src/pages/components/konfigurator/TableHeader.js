import * as React from 'react'

// ** Next Import
import Link from 'next/link'

import { styled } from '@mui/material/styles'
import Accordion from '@mui/material/Accordion'
import AccordionSummary from '@mui/material/AccordionSummary'
import AccordionDetails from '@mui/material/AccordionDetails'
import Typography from '@mui/material/Typography'
import { Box, Button } from '@mui/material'

// ** Icon Imports
import Icon from 'src/@core/components/icon'
import TableDataGrid from 'src/pages/components/konfigurator/TableDataGrid'

// ** Store Imports
import { useDispatch, useSelector } from 'react-redux'
import { konfiguratorActions } from 'src/store/apps/konfigurator'

const StyledLink = styled(Link)(({ theme }) => ({
  textDecoration: 'none',
  borderColor: 'red',
  boxSizing: 'border-box',
  marginLeft: '15px'
}))

export default function TableHeader(props) {
  // ** Hooks

  const dispatch = useDispatch()
  const store = useSelector(state => state.konfigurator)
  const m1 = store.data.flex

  // ** Handlers

  const onDeleteHandler = e => {
    dispatch(konfiguratorActions.deleteKonfig(e.target.value))
  }

  return (
    //Check if m1 is empty
    m1.length === 0 ? (
      <Typography>Keine Konfigurationen vorhanden</Typography>
    ) : (
      //Else m1 is not empty
      <Box sx={{ width: '100%', mt: 5 }}>
        {m1.map(data => (
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
                {/* <Button
                  sx={{ marginLeft: '15px' }}
                  component={Link}
                  variant='contained'
                  color='success'
                  size='small'
                  href={`/konfigurator/biro40/view/${data.id}`}
                >
                  Details
                </Button> */}
                <TableDataGrid id={data.id}></TableDataGrid>
              </Typography>
            </AccordionDetails>
          </Accordion>
        ))}
      </Box>
    )
  )
}
