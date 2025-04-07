// ** React Imports
import { useState, useEffect, useContext, Fragment } from 'react'

// ** Loader

// ** Redux
import { useDispatch, useSelector } from 'react-redux'

// ** MUI Imports
import Card from '@mui/material/Card'
import Grid from '@mui/material/Unstable_Grid2'
import Button from '@mui/material/Button'
import CardHeader from '@mui/material/CardHeader'
import CardActions from '@mui/material/CardActions'
import { konfiguratorActions } from 'src/store/apps/konfigurator'
import Table from '@mui/material/Table'
import TableRow from '@mui/material/TableRow'
import TableBody from '@mui/material/TableBody'
import Typography from '@mui/material/Typography'
import Translations from 'src/layouts/components/Translations'
import { styled } from '@mui/material/styles'
import TableCell from '@mui/material/TableCell'

// ** Third Party Imports
import calculateSpot from 'src/pages/konfigurator/spot/berechnung/calc'
import AddKonfigDrawer from 'src/pages/components/konfigurator/AddKonfigDrawer'
import SpotDropDownGehaeuse from './SpotDropDownGehaeuse'
import SpotDropDownLED from './SpotDropDownLED'
import SpotDropDownTreiber from './SpotDropDownTreiber'
import DropdownContext from 'src/context/dropdownContext'

const config = {
  headers: {
    'content-type': 'application/json',
    Accept: 'application/json'
  }
}

const MUITableCell = styled(TableCell)(({ theme }) => ({
  borderBottom: 0,
  padding: `${theme.spacing(1, 0)} !important`
}))

const SpotForm = props => {
  // **Store
  const dispatch = useDispatch()
  const store = useSelector(state => state.konfigurator)
  const dropdownCtx = useContext(DropdownContext)

  // ** States
  const [dropValues, setdropValue] = useState({})
  const [calc, setCalc] = useState()
  const [id, setId] = useState()
  const [gehaeuse, setgeheause] = useState()
  const [led, setled] = useState()
  const [treiber, settreiber] = useState()
  const toggleAddKonfigDrawer = () => setAddKonfigrOpen(!addKonfigOpen)
  const [addKonfigOpen, setAddKonfigrOpen] = useState(false)

  // ** Handlers

  // ** Effect

  useEffect(() => {
    fetch('/api/spot/getCalc', { method: 'POST', body: JSON.stringify(dropdownCtx.dropDownValues) })
      .then(response => {
        return response.json()
      })
      .then(data => {
        if (data[0] !== undefined) {
          return {
            id: data[0].ID,
            calc: JSON.parse(
              calculateSpot({
                E_Wunschmenge: data[0].Anzahl,
                E_Lampenplatz: data[0].Lampenplatz,
                E_Min_Anzahl: data[0].Min_Anzahl,
                E_Max_Anzahl: data[0].Max_Anzahl,
                E_Artikelnummer_Treiber: data[0].Artikelnummer_Treiber,
                E_Artikelnummer_LED: data[0].Artikelnummer_LED,
                E_Artikelnummer_Gehaeuse: data[0].Artikelnummer_Gehaeuse
              })
            )
          }
        }
      })
      .then(calc => {
        setId(calc.id)
        fetch('/api/spot/getArtikelGehaeuse', { method: 'POST', body: JSON.stringify(calc.calc) })
          .then(response => response.json())
          .then(data => {
            setgeheause(data[0])
          })
        fetch('/api/spot/getArtikelLED', { method: 'POST', body: JSON.stringify(calc.calc) })
          .then(response => response.json())
          .then(data => {
            setled(data[0])
          })
        fetch('/api/spot/getArtikelTreiber', { method: 'POST', body: JSON.stringify(calc.calc) })
          .then(response => response.json())
          .then(data => {
            settreiber(data[0])
          })
      })
  }, [dropdownCtx])

  const onAddHandler = () => {
    let config = {
      id: id,
      positions: [gehaeuse, led, treiber]
    }
    dispatch(konfiguratorActions.addKonfig(config))
    toggleAddKonfigDrawer()
  }

  const onDeleteHandler = () => {}
  const onCalcHandler = () => {}

  // ** Alle Parameter übergeben

  return (
    <Fragment>
      <AddKonfigDrawer open={addKonfigOpen} toggle={toggleAddKonfigDrawer} />
      <Card>
        {/* <CardHeader title='In drei Schritten zur individuellen Leuchte' titleTypographyProps={{ variant: 'h4' }} /> */}
        <form onSubmit={e => e.preventDefault()}>
          <Grid container spacing={2} alignItems={'flex-start'} justifyContent={'start'} sx={{ p: 5 }}>
            <Grid xs={12} lg={12} sx={{ borderTop: 2, borderColor: '#000' }}>
              <Table sx={{ maxWidth: '2250px' }}>
                <TableBody>
                  <TableRow>
                    <MUITableCell>
                      <TableRow>
                        <MUITableCell>
                          <svg
                            height='1.5em'
                            viewBox='0 0 512 512'
                            width='1.em'
                            xmlns='http://www.w3.org/2000/svg'
                            data-name='Layer 1'
                            {...props}
                          >
                            <path d='M256 6C117.929 6 6 117.929 6 256s111.929 250 250 250 250-111.929 250-250S394.071 6 256 6zm52.075 374.689h-67.182V187.824h-36.968v-56.513h104.15z' />
                          </svg>
                        </MUITableCell>
                        <MUITableCell>
                          <Typography sx={{ pl: 5 }} variant=''>
                            <Translations text={'Wählen Sie'} />
                          </Typography>
                        </MUITableCell>
                      </TableRow>

                      <Typography variant='h6'>
                        <Translations text={'Gehäuseform'} />,
                      </Typography>
                      <Typography variant='h6'>
                        <Translations text={'Modulhalterung'} />
                      </Typography>
                      <Typography variant='h6'>
                        <Translations text={'Gehäusefarbe'} />
                      </Typography>
                    </MUITableCell>
                  </TableRow>
                </TableBody>
              </Table>
            </Grid>

            <SpotDropDownGehaeuse></SpotDropDownGehaeuse>
            <Grid xs={12} lg={12} sx={{ borderTop: 2, borderColor: '#000' }}>
              <Table sx={{ maxWidth: '2250px' }}>
                <TableBody>
                  <TableRow>
                    <MUITableCell>
                      <TableRow>
                        <MUITableCell>
                          <svg
                            height='1.5em'
                            viewBox='0 0 512 512'
                            width='1.5em'
                            xmlns='http://www.w3.org/2000/svg'
                            data-name='Layer 1'
                            {...props}
                          >
                            <path d='M256 6C117.929 6 6 117.929 6 256s111.929 250 250 250 250-111.929 250-250S394.071 6 256 6zm92.738 377.871H163.262v-15.18C263.6 250.347 277.42 231.222 277.42 209.812c0-13.522-8.909-22.59-21.682-22.59-14 0-22.535 9.442-22.535 24.454v4.824h-65.922v-4.613c0-50.423 33.05-83.753 87.651-83.753 52.9 0 89.423 32.524 89.423 79.343 0 31.381-11.61 55.471-64.947 117.254h69.33z' />
                          </svg>
                        </MUITableCell>
                        <MUITableCell>
                          <Typography sx={{ pl: 5 }} variant=''>
                            <Translations text={'Wählen Sie'} />
                          </Typography>
                        </MUITableCell>
                      </TableRow>
                      <Typography variant='h6'>
                        <Translations text={'LED-Module'} />
                      </Typography>
                    </MUITableCell>
                  </TableRow>
                </TableBody>
              </Table>
            </Grid>
            <SpotDropDownLED></SpotDropDownLED>

            <Grid xs={12} lg={12} sx={{ borderTop: 2, borderColor: '#000' }}>
              <Table sx={{ maxWidth: '2250px' }}>
                <TableBody>
                  <TableRow>
                    <MUITableCell>
                      <TableRow>
                        <MUITableCell>
                          <svg
                            height='1.5em'
                            viewBox='0 0 512 512'
                            width='1.5em'
                            xmlns='http://www.w3.org/2000/svg'
                            data-name='Layer 1'
                            {...props}
                          >
                            <path d='M256 6C117.929 6 6 117.929 6 256s111.929 250 250 250 250-111.929 250-250S394.071 6 256 6zm-1.045 377.577c-53.591 0-90.432-34.981-91.931-86.6h64.009c.749 17.58 11.682 29.262 28.081 29.262 17.046 0 29-12.548 29-30.773s-12.388-29.536-31.795-29.536h-39.945v-13.9l40.608-66.763h-83.7v-56.844H340.4v11.457l-50.052 80.127c35.754 8.97 58.628 37.913 58.628 76.535 0 50.716-39.304 87.035-94.021 87.035z' />
                          </svg>
                        </MUITableCell>
                        <MUITableCell>
                          <Typography sx={{ pl: 5 }} variant=''>
                            <Translations text={'Wählen Sie'} />
                          </Typography>
                        </MUITableCell>
                      </TableRow>
                      <Typography variant='h6'>
                        <Translations text={'Konverter'} />
                      </Typography>
                    </MUITableCell>
                  </TableRow>
                </TableBody>
              </Table>
            </Grid>

            <SpotDropDownTreiber></SpotDropDownTreiber>

            {/* </CardContent> */}
            <Grid xs={12} lg={12} sx={{ borderTop: 2, borderColor: '#000' }}>
              <CardActions>
                <Button onClick={onAddHandler} size='large' type='submit' sx={{ mr: 2 }} variant='contained'>
                  <Translations text={'Konfiguration hinzufügen'} />
                </Button>
                <Button onClick={toggleAddKonfigDrawer} size='large' type='submit' sx={{ mr: 2 }} variant='contained'>
                  <Translations text={'Konfiguration anzeigen'} />
                </Button>
              </CardActions>
            </Grid>
          </Grid>
        </form>
      </Card>
    </Fragment>
  )
}

export default SpotForm
