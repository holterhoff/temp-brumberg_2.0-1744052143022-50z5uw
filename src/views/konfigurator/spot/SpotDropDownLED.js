import React, { Fragment } from 'react'
import { useState, useEffect, useContext } from 'react'

// ** Context
import DropdownContext from 'src/context/dropdownContext'

/** MUI Imports */
import Translations from 'src/layouts/components/Translations'
import Grid from '@mui/material/Unstable_Grid2'
import { Link } from '@mui/material'
//** Custom */
import FlexSelect2 from 'src/pages/components/input/FlexSelect2'
import ImageSelector from 'src/pages/components/konfigurator/ImageSelector'
import Svg25WattsLampIndicator from './icons/25Watt'
import SvgLightBulb from './icons/LedLightBulb'
import SvgSmartLight from './icons/SmartLight'
import SvgAngle from './icons/angle'
//** Axios */
import axios from 'axios'

const defaultDetails = [{ Bezeichnung: '', Artikelnummer: '', Preis: '', Produktbeschreibung: '' }]

const SpotDropDownLED = props => {
  // ** States
  const [params, setParams] = useState([])
  const [details, setDetails] = useState([defaultDetails])

  //** Context
  const dropdownCtx = useContext(DropdownContext)

  //** HOOK */
  const currentLanguage = localStorage.getItem('i18nextLng')

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
      url: '/api/spot/led/getLEDdetails',
      method: 'POST',
      data: JSON.stringify(dropdownCtx.dropDownValues),
      headers: {
        'content-type': 'application/json',
        Accept: 'application/json'
      }
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
      <Grid container spacing={2} alignItems={'center'} justifyContent={'space-around'} sx={{ marginTop: '10rem' }}>
        <Grid xs={4} lg={2}>
          <ImageSelector
            label={'LED'}
            konfigurator='spot'
            url={'/api/spot/led/getImageLED'}
            imagePath={'/images/konfigurator/'}
            defaultImage={'/images/konfigurator/blank.jpg'}
            params={dropdownCtx.dropDownValues}
          ></ImageSelector>
        </Grid>
        <Grid xs={12} lg={3}>
          <FlexSelect2
            selectValue={onSetDropdownParamsHandler}
            konfigurator='spot'
            label={'Ausführung'}
            url={'/api/spot/led/getFarbkanal'}
            params={dropdownCtx.dropDownValues}
            icon={<SvgLightBulb />}
          ></FlexSelect2>
          <FlexSelect2
            selectValue={onSetDropdownParamsHandler}
            konfigurator='spot'
            label={'Lichtfarbe'}
            url={'/api/spot/led/getLichtfarben'}
            params={dropdownCtx.dropDownValues}
            icon={<SvgSmartLight />}
          ></FlexSelect2>
          <FlexSelect2
            selectValue={onSetDropdownParamsHandler}
            konfigurator='spot'
            label={'Leistung'}
            url={'/api/spot/led/getLeistung'}
            params={dropdownCtx.dropDownValues}
            icon={<Svg25WattsLampIndicator />}
          ></FlexSelect2>
          <FlexSelect2
            selectValue={onSetDropdownParamsHandler}
            konfigurator='spot'
            label={'Abstrahlwinkel'}
            url={'/api/spot/led/getAbstrahlwinkel'}
            params={dropdownCtx.dropDownValues}
            icon={<SvgAngle />}
          ></FlexSelect2>
        </Grid>
        <Grid xs={12} lg={6}>
          <Grid container spacing={2} sx={{ fontWeight: 'bold' }}>
            <Grid xs={6}>
              <Translations text={'Bezeichnung'} />
            </Grid>
            <Grid xs={3}>
              <Translations text={'Artikelnummer'} />
            </Grid>
            <Grid xs={3}>
              <Translations text={'Bruttopreis'} />
            </Grid>
            {/* <Grid xs={3}>Gesamtpreis</Grid> */}
          </Grid>
          <Grid container spacing={2} sx={{ fontSize: '0.8rem' }}>
            {currentLanguage === 'de' ? (
              <Grid xs={6}>{details[0].bezeichnung_de}</Grid>
            ) : (
              <Grid xs={6}>{details[0].bezeichnung_en}</Grid>
            )}
            <Grid xs={3}>
              <Link href={details[0].seo_url} target={'_blank'}>
                {details[0].Artikelnummer}{' '}
              </Link>
            </Grid>
            <Grid xs={3}>{details[0].preis} €</Grid>
            {/* <Grid xs={3}>105,85 €</Grid> */}
          </Grid>
          <Grid container spacing={2} sx={{ paddingTop: '50px', fontSize: '0.8rem' }}>
            {currentLanguage === 'de' ? (
              <Grid xs={6}>{details[0].produktbeschreibung_de}</Grid>
            ) : (
              <Grid xs={6}>{details[0].produktbeschreibung_en}</Grid>
            )}
          </Grid>
        </Grid>
      </Grid>
    </Fragment>
  )
}

export default SpotDropDownLED
