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
import Plus_Minus_Button from 'src/pages/components/plusminus-button'

//** Axios */
import axios from 'axios'

//** ICONS */
import SvgShapes from './icons/shapes'
import SvgNumberBlocks from './icons/numberblocks'
import SvgPantone from './icons/ColorPanton'
import SvgInstallation from './icons/Installation'

const defaultDetails = [{ Bezeichnung: '', Artikelnummer: '', Preis: '', Produktbeschreibung: '' }]

const M1DropDownGehaeuse = props => {
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
      url: '/api/m1/gehaeuse/getGehaeusedetails',
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
            konfigurator='m1'
            url={'/api/m1/gehaeuse/getImageGehaeuse'}
            imagePath={'/images/konfigurator/'}
            defaultImage={'/images/konfigurator/blank.jpg'}
            params={dropdownCtx.dropDownValues}
          ></ImageSelector>
        </Grid>
        <Grid xs={12} lg={3}>
          <FlexSelect2
            selectValue={onSetDropdownParamsHandler}
            konfigurator='m1'
            label={'Form'}
            disabled={true}
            url={'/api/m1/gehaeuse/getGehaeuseform'}
            params={dropdownCtx.dropDownValues}
            icon={<SvgShapes />}
          ></FlexSelect2>
          <FlexSelect2
            selectValue={onSetDropdownParamsHandler}
            konfigurator='m1'
            label={'Anzahl Leuchtmittel'}
            disabled={true}
            url={'/api/m1/gehaeuse/getAnzahlLeuchtmittel'}
            params={dropdownCtx.dropDownValues}
            icon={<SvgNumberBlocks />}
          ></FlexSelect2>
          <FlexSelect2
            selectValue={onSetDropdownParamsHandler}
            konfigurator='m1'
            label={'Leuchtentyp'}
            disabled={true}
            url={'/api/m1/gehaeuse/getLeuchtentyp'}
            params={dropdownCtx.dropDownValues}
            icon={<SvgInstallation />}
          ></FlexSelect2>
          <FlexSelect2
            selectValue={onSetDropdownParamsHandler}
            konfigurator='m1'
            label={'Farbe'}
            disabled={true}
            url={'/api/m1/gehaeuse/getGehaeusefarbe'}
            params={dropdownCtx.dropDownValues}
            icon={<SvgPantone />}
          ></FlexSelect2>
          <FlexSelect2
            selectValue={onSetDropdownParamsHandler}
            konfigurator='m1'
            label={'Verstellbarkeit'}
            disabled={true}
            url={'/api/m1/gehaeuse/getVerstellbarkeit'}
            params={dropdownCtx.dropDownValues}
          ></FlexSelect2>{' '}
          <Plus_Minus_Button
            selectValue={onSetDropdownParamsHandler}
            konfigurator='m1'
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
              <Link href={details[0].seo_url} target={'_blank'}>
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

export default M1DropDownGehaeuse
