import React, { Fragment } from 'react'
import { useState, useEffect, useContext } from 'react'

// ** Context
import DropdownContext from 'src/context/dropdownContext'

/** MUI Imports */
import Grid from '@mui/material/Unstable_Grid2'

//** Custom */
import FlexSelect from 'src/pages/components/input/FlexSelect'
import ImageSelector from 'src/pages/components/konfigurator/ImageSelector'

//** Axios */
import axios from 'axios'
import { Link } from '@mui/material'

const config = {
  headers: {
    'content-type': 'application/json',
    Accept: 'application/json'
  }
}

const defaultDetails = [{ Bezeichnung: '', Artikelnummer: '', Preis: '', Produktbeschreibung: '' }]

const BirocircleDropDownGehaeuse = props => {
  // ** States
  const [params, setParams] = useState([])
  const [details, setDetails] = useState([defaultDetails])

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

  // ** Schicke die Parameter aus den DropDowns hoch in die Form Komponente
  useEffect(() => {
    // ** Paramter in Context schreiben

    axios({
      url: '/api/birocircle/getBirocircleDetails',
      method: 'POST',
      data: JSON.stringify(dropdownCtx.dropDownValues),
      headers: config.headers
    }).then(res => {
      if (res.data.length > 0) {
        setDetails(res.data)
      } else {
        setDetails(defaultDetails)
      }
    })
  }, [params])

  return (
    <Fragment>
      {/*  Gehäuse */}
      <Grid container spacing={2} alignItems={'flex-start'} justifyContent={'space-around'}>
        <Grid xs={4} lg={2}>
          {/* <ImageSelector
            label={'Gehäuse'}
            url={'/api/m1/getImageGehaeuse'}
            imagePath={'/images/konfigurator/Birocircle/gehaeuse/'}
            defaultImage={'/images/konfigurator/Birocircle/gehaeuse/1.1.1.jpg'}
            params={dropdownCtx.dropDownValues}
          ></ImageSelector> */}
        </Grid>
        <Grid xs={12} lg={3}>
          <FlexSelect
            selectValue={onSetDropdownParamsHandler}
            konfigurator='Birocircle'
            label={'Leuchtentyp'}
            url={'/api/birocircle/getLeuchtentyp'}
            params={dropdownCtx.dropDownValues}
          ></FlexSelect>
          <FlexSelect
            selectValue={onSetDropdownParamsHandler}
            konfigurator='Birocircle'
            label={'Durchmesser'}
            url={'/api/birocircle/getDurchmesser'}
            params={dropdownCtx.dropDownValues}
          ></FlexSelect>
          <FlexSelect
            selectValue={onSetDropdownParamsHandler}
            konfigurator='Birocircle'
            label={'Gehäusefarbe'}
            url={'/api/birocircle/getGehaeusefarbe'}
            params={dropdownCtx.dropDownValues}
          ></FlexSelect>
          <FlexSelect
            selectValue={onSetDropdownParamsHandler}
            konfigurator='Birocircle'
            label={'Lichtfarbe'}
            url={'/api/birocircle/getLichtfarbe'}
            params={dropdownCtx.dropDownValues}
          ></FlexSelect>
          <FlexSelect
            selectValue={onSetDropdownParamsHandler}
            konfigurator='Birocircle'
            label={'Schaltungsart'}
            url={'/api/birocircle/getSchaltungsart'}
            params={dropdownCtx.dropDownValues}
          ></FlexSelect>
        </Grid>
        <Grid xs={12} lg={6}>
          <Grid container spacing={2} sx={{ fontWeight: 'bold' }}>
            <Grid xs={6}>Bezeichnung</Grid>
            <Grid xs={3}>Artikelnummer</Grid>
            <Grid xs={3}>Einzelpreis</Grid>
            {/* <Grid xs={3}>Gesamtpreis</Grid> */}
          </Grid>
          <Grid container spacing={2} sx={{ fontSize: '0.8rem' }}>
            <Grid xs={6}>{details[0].Bezeichnung}</Grid>
            <Grid xs={3}>
              <Link href={details[0].Website}>{details[0].Artikelnummer} </Link>
            </Grid>
            <Grid xs={3}>{details[0].Preis} €</Grid>
            {/* <Grid xs={3}>105,85 €</Grid> */}
          </Grid>
          <Grid container spacing={2} sx={{ paddingTop: '50px', fontSize: '0.8rem' }}>
            <Grid xs={12}>{details[0].Produktbeschreibung}</Grid>
          </Grid>
        </Grid>
      </Grid>
    </Fragment>
  )
}

export default BirocircleDropDownGehaeuse
