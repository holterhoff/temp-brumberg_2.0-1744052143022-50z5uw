import React, { Fragment, useState, useContext } from 'react'
import Grid from '@mui/material/Grid'
import Box from '@mui/material/Box'
import FlexSelect from 'src/pages/components/input/FlexSelect'
import SvgShapes from './icons/shapes'
import DropdownContext from 'src/context/dropdownContext'

const defaultDetails = [{ Bezeichnung: '', Artikelnummer: '', Preis: '', Produktbeschreibung: '' }]

const MontageOptions = props => {
  const { label, fullWidth } = props
  // ** States
  const [params, setParams] = useState([])
  const [details, setDetails] = useState([defaultDetails])

  //** Context
  const dropdownCtx = useContext(DropdownContext)

  // ** Handler
  const onSetDropdownParamsHandler = selectedValue => {
    setParams(prevState => [...prevState.filter(item => item.label !== selectedValue.label), selectedValue])
    dropdownCtx.addDropdownValues(prevState => [
      ...prevState.filter(item => item.label !== selectedValue.label),
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
          {/* Box-Container für responsives Verhalten */}
          <Box sx={{ width: 300, mx: 'auto' }}>
            <FlexSelect
              isDropDown={true}
              selectValue={onSetDropdownParamsHandler}
              disabled={true}
              label={label}
              konfigurator='biro40'
              url='/api/biro40/getMontageart'
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

export default MontageOptions
