import React, { Fragment } from 'react'
import { useState, useEffect, useContext } from 'react'

// ** Context
import DropdownContext from 'src/context/dropdownContext'
import useOptionsStore from 'src/store/apps/konfigurator/optionsStore'
/** MUI Imports */
//import Grid from '@mui/material/Unstable_Grid2'
import Grid from '@mui/material/Grid'
import Translations from 'src/layouts/components/Translations'
import { TextField } from '@mui/material'
//** Custom */

//** Axios */

const defaultDetails = [{ Bezeichnung: '', Artikelnummer: '', Preis: '', Produktbeschreibung: '' }]

const LVPosition = props => {
  const { label, onChange } = props // onChange als Prop übernehmen
  // ** States
  const [params, setParams] = useState([])
  const [details, setDetails] = useState([defaultDetails])
  const { options, setChoice, resetWunschmassOptions } = useOptionsStore()

  //** HOOK */
  const currentLanguage = localStorage.getItem('i18nextLng')

  //** Context
  const dropdownCtx = useContext(DropdownContext)

  // ** Handlers
  const onSetDropdownParamsHandler = selectedValue => {
    if (selectedValue === '') {
      setChoice('lv_position', 'LV Position')
    } else {
      setChoice('lv_position', selectedValue)
    }
  }

  return (
    <Fragment>
      {/*  Gehäuse */}
      <Grid
        container
        spacing={2}
        alignItems={'center'}
        justifyContent={'left'}
        sx={{
          // border: '1px solid black',
          backgroundColor: '#fff',
          borderRadius: '10px',
          p: 2
        }}
      >
        <Grid item xs={12} lg={3}>
          <TextField
            label='LV Position'
            variant='outlined'
            fullWidth
            // value={lv_position}
            onChange={e => onSetDropdownParamsHandler(e.target.value)}
            sx={{ mt: 2 }}
          />
        </Grid>
      </Grid>
    </Fragment>
  )
}

export default LVPosition
