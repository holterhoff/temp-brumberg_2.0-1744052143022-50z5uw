import React, { Fragment } from 'react'
import { useState, useEffect, useContext } from 'react'

// ** Context
import DropdownContext from 'src/context/dropdownContext'

/** MUI Imports */
//import Grid from '@mui/material/Unstable_Grid2'
import Grid from '@mui/material/Grid'

import { Box, Link } from '@mui/material'
import Translations from 'src/layouts/components/Translations'
//** Custom */
import FlexSelect from 'src/pages/components/input/FlexSelect'
import SvgShapes from './icons/shapes'

//** Axios */

const defaultDetails = [{ Bezeichnung: '', Artikelnummer: '', Preis: '', Produktbeschreibung: '' }]

const FigurOptions = props => {
  const { label, onChange, fullWidth } = props // onChange als Prop übernehmen
  // ** States
  const [params, setParams] = useState([])
  const [details, setDetails] = useState([defaultDetails])

  //** HOOK */
  const currentLanguage = localStorage.getItem('i18nextLng')

  //** Context
  const dropdownCtx = useContext(DropdownContext)

  // ** Handlers
  const onSetDropdownParamsHandler = selectedValue => {
    setParams(prevState => [...prevState.filter(items => items.label !== selectedValue.label), selectedValue])
    dropdownCtx.addDropdownValues(prevState => [
      ...prevState.filter(items => items.label !== selectedValue.label),
      selectedValue
    ])
  }

  return (
    <Fragment>
      <Grid
        container
        spacing={2}
        alignItems='center'
        justifyContent='left'
        sx={{
          backgroundColor: '#fff',
          borderRadius: '10px',
          p: 2
        }}
      >
        <Grid item xs={12}>
          {/* Box mit maxWidth sorgt dafür, dass das Dropdown nicht zu breit oder beschnitten wird */}
          <Box sx={{ width: 300, mx: 'auto' }}>
            <FlexSelect
              isDropDown={true}
              selectValue={onSetDropdownParamsHandler}
              disabled={true}
              label={label}
              konfigurator='biro40'
              url='/api/biro40/getFigur'
              params={dropdownCtx.dropDownValues}
              icon={<SvgShapes />}
              fullWidth={false}
            />
          </Box>
        </Grid>
      </Grid>
    </Fragment>
  )
}

export default FigurOptions
