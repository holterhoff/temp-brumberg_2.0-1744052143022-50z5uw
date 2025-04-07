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

import SvgShapes from './icons/shapes'
import SvgLedLight from './icons/LedLightIcon'
import SvgPantone from './icons/ColorPanton'

//** Axios */
import axios from 'axios'
import Plus_Minus_Button from 'src/pages/components/plusminus-button'

const defaultDetails = [{ Bezeichnung: '', Artikelnummer: '', Preis: '', Produktbeschreibung: '' }]

const SpotDropDownGehaeuse = props => {
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

  // ** Schicke die Parameter aus den DropDowns hoch in die Form Komponente
  useEffect(() => {
    // ** Paramter in Context schreiben

    axios({
      url: '/api/spot/gehaeuse/getGehaeusedetails',
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
      <Grid container spacing={2} alignItems={'center'} justifyContent={'space-around'}>
        <Grid xs={4} lg={2}>
          <ImageSelector
            label={'Gehäuse'}
            konfigurator='spot'
            url={'/api/spot/gehaeuse/getImageGehaeuse'}
            imagePath={'/images/konfigurator/'}
            defaultImage={'/images/konfigurator/blank.jpg'}
            params={dropdownCtx.dropDownValues}
          ></ImageSelector>
        </Grid>
        <Grid xs={12} lg={3}>
          <FlexSelect2
            selectValue={onSetDropdownParamsHandler}
            label={'Form'}
            konfigurator='spot'
            url={'/api/spot/gehaeuse/getGehaeuseform'}
            params={dropdownCtx.dropDownValues}
            icon={<SvgShapes />}
          ></FlexSelect2>
          <FlexSelect2
            selectValue={onSetDropdownParamsHandler}
            label={'Einbautiefe'}
            konfigurator='spot'
            url={'/api/spot/gehaeuse/getEinbautiefe'}
            params={dropdownCtx.dropDownValues}
            icon={<SvgShapes />}
          ></FlexSelect2>
          <FlexSelect2
            selectValue={onSetDropdownParamsHandler}
            konfigurator='spot'
            label={'Typ'}
            url={'/api/spot/gehaeuse/getLeuchtentyp'}
            params={dropdownCtx.dropDownValues}
            icon={<SvgLedLight />}
          ></FlexSelect2>

          <Plus_Minus_Button
            selectValue={onSetDropdownParamsHandler}
            konfigurator='spot'
            label={'Anzahl'}
            min={0}
            max={10000}
            step={1}
            defaultValue={1}
          ></Plus_Minus_Button>
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
              <Link href={details[0].SEO_Url} target={'_blank'}>
                {details[0].artikelnummer}
              </Link>
            </Grid>
            <Grid xs={3}>{details[0].preis} €</Grid>
            {/* <Grid xs={3}>105,85 €</Grid> */}
          </Grid>
          <Grid container spacing={2} sx={{ paddingTop: '50px', fontSize: '0.8rem' }}>
            {currentLanguage === 'de' ? (
              <Grid xs={6}>{details[0].produktbeschreibung_gehaeuse_de}</Grid>
            ) : (
              <Grid xs={6}>{details[0].produktbeschreibung_gehaeuse_en}</Grid>
            )}
          </Grid>
        </Grid>
      </Grid>
    </Fragment>
  )
}

export default SpotDropDownGehaeuse
