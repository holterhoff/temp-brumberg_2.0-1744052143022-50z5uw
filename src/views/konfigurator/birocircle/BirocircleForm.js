// ** React Imports
import { useState, useEffect, useContext } from 'react'

// ** Loader

// ** Redux
import { useDispatch, useSelector } from 'react-redux'

// ** MUI Imports
import Card from '@mui/material/Card'
import Grid from '@mui/material/Unstable_Grid2'
import Button from '@mui/material/Button'
import Divider from '@mui/material/Divider'
import CardHeader from '@mui/material/CardHeader'
import CardActions from '@mui/material/CardActions'

import { konfiguratorActions } from 'src/store/apps/konfigurator'

// ** Third Party Imports

import Plus_Minus_Button from 'src/pages/components/plusminus-button'

// ** Icons Imports
import { FormGroup } from '@mui/material'
import BirocircleDropDownGehaeuse from './BirocircleyDropDownGehaeuse'

import DropdownContext from 'src/context/dropdownContext'

const config = {
  headers: {
    'content-type': 'application/json',
    Accept: 'application/json'
  }
}

const DUMMY_DATA = {
  id: '01-03-1234567890',
  positions: [
    {
      id: 0,
      bezeichnung: '24V LED Stripe IP00, 380lm/m, 2700K, 4,8W/m - 5000 mm (24 W)',
      artikelnummer: 'B15201027',
      zusatz: '5000',
      menge: 1,
      bp_produkt: 63.7,
      bp_gesamt: 63.7
    },
    {
      id: 1,
      bezeichnung: '24V LED Driver 25W',
      artikelnummer: '370202500',
      zusatz: '0',
      menge: 1,
      bp_produkt: 68.82,
      bp_gesamt: 68.82
    }
  ]
}

const BirocircleForm = props => {
  // **Store
  const dispatch = useDispatch()
  const store = useSelector(state => state.konfigurator)

  const dropdownCtx = useContext(DropdownContext)

  // ** States

  const [imageFigur, setImageFigur] = useState(
    'https://www.brumberg.com/fileadmin/Biro-40-Konfigurator/Footage/FIGUR_I.jpg'
  )

  // ** Handlers
  //** Dieser Handler bekommt den Wert aus der Select Komponente (Ebene tiefer)

  const onAddHandler = () => {
    dispatch(konfiguratorActions.addKonfig(DUMMY_DATA))
  }

  const onDeleteHandler = () => {}
  const onCalcHandler = () => {}

  // ** Alle Parameter übergeben
  //setformParams(filtered)

  return (
    <Card>
      <CardHeader title='Parametereingabe' titleTypographyProps={{ variant: 'h6' }} />
      <Divider sx={{ mt: 5 }} />
      <form onSubmit={e => e.preventDefault()}>
        <BirocircleDropDownGehaeuse></BirocircleDropDownGehaeuse>
        <Grid container alignItems='center' spacing={0} item sx={{ padding: '10px', borderRadius: '10px' }}>
          <Grid item xs={12} md={3} lg={3}>
            <FormGroup>
              {/* <FlexSelect selectValue = {onFigurChangeHandler} label={'Figur'} url={'http://localhost:4000/api/getFigur'}></FlexSelect>
                  <FlexSelect label={'Montage'} url={'http://localhost:4000/api/getMontage'}></FlexSelect>
                  <FlexSelect label={'Profil'} url={'http://localhost:4000/api/getProfil'}></FlexSelect> */}
            </FormGroup>
          </Grid>
        </Grid>
        {/* </CardContent> */}
        <CardActions>
          <Button onClick={onAddHandler} size='large' type='submit' sx={{ mr: 2 }} variant='contained'>
            Submit
          </Button>
          <Button size='large' color='secondary' variant='outlined'>
            Cancel
          </Button>
          <Button onClick={onCalcHandler} size='large' color='secondary' variant='outlined'>
            Calc
          </Button>
        </CardActions>
      </form>
    </Card>
  )
}

export default BirocircleForm
