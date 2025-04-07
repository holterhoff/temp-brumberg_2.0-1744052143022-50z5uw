import React, { Fragment } from 'react'
import { useState, useEffect, useContext } from 'react'

// ** Context
import DropdownContext from 'src/context/dropdownContext'

/** MUI Imports */
//import Grid from '@mui/material/Unstable_Grid2'
import Grid from '@mui/material/Grid'
//** Custom */
import FlexWunsch from '../../../pages/components/input/FlexWunsch'
import SvgShapes from './icons/shapes'

//** Axios method */

const LaengenOptions = props => {
  const label = props.label
  const schenkel = props.schenkel
  const basismass = props.basismass

  // ** States
  const [params, setParams] = useState([])

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
          <FlexWunsch
            isDropDown={true}
            selectValue={onSetDropdownParamsHandler}
            disabled={true}
            label={label}
            konfigurator='biro40'
            url={'/api/biro40/getLaengen'}
            params={params}
            schenkel={schenkel}
            basismass={basismass}
            icon={<SvgShapes />}
          ></FlexWunsch>
        </Grid>
      </Grid>
    </Fragment>
  )
}

export default LaengenOptions
