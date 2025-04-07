import { useState, useEffect, useContext, Fragment } from 'react'
import axios from 'axios'
// ** MUI Imports
import Card from '@mui/material/Card'
import Grid from '@mui/material/Unstable_Grid2'
import CardContent from '@mui/material/CardContent'
import Typography from '@mui/material/Typography'
import Button from '@mui/material/Button'
import Box from '@mui/material/Box'
import Divider from '@mui/material/Divider'
import { Input } from '@mui/material'

// Custom Imports
import Translations from 'src/layouts/components/Translations'
import calculateBiro40 from 'src/pages/konfigurator/biro40/js/calc'

//** Context
import useOptionsStore from 'src/store/apps/konfigurator/optionsStore'
import DropdownContext from 'src/context/dropdownContext'

//* Custom components
import AddKonfigDrawer from 'src/pages/components/konfigurator/AddKonfigDrawer'
import TableDataGridBir040 from './TableDataGridBir040'
import AlertDialogSlide from './AlertDialog'
import FigurOptions from './FigurOptions'
import MontageOptions from './MontageOptions'
import GehaeusefarbeOptions from './GehaeusefarbeOptions'
import LichtfarbeOptions from './LichtfarbeOptions'
import AnsteuerungOptions from './AnsteuerungOptions'
import OptikOptions from './OptikOptions'
import LaengenOptions from './LaengenOptions'
import LVPosition from './LVPosition'

const requiredKeys = ['figur', 'montageart', 'gehäusefarbe', 'lichtfarbe', 'ansteuerung', 'optischessystem']

const areRequiredFieldsFilled = options => requiredKeys.every(key => options[key] && options[key].trim() !== '')

const Biro40Form = () => {
  //**  States
  const {
    getChoice,
    options,
    setChoice,
    resetChoices,
    wunschmassOptions,
    getWunschmassOptions,
    setWunschmassChoice,
    output,
    setOutput,
    setKep,
    getKep,
    getOutput
  } = useOptionsStore()
  const [wunschmassFields, setWunschmassFields] = useState({ fields: 1, figur: 'I' })
  const [addKonfigOpen, setAddKonfigrOpen] = useState(false)
  const [showTableDataGrid, setShowTableDataGrid] = useState(false)
  const [searchId, setSearchId] = useState('')
  const [openDialog, setOpenDialog] = useState(false)
  const [refreshKey, setRefreshKey] = useState(0)
  const [selectedConfig, setSelectedConfig] = useState(null)

  //** Context
  const dropdownCtx = useContext(DropdownContext)

  // Determine if the required fields are filled
  const isReadyForLaengenOptions = areRequiredFieldsFilled(options)

  // ** UseEffect to set the dropdown values in the context
  useEffect(() => {
    const figur = getChoice('figur')
    // Adjust the number of Wunschmass fields based on the selected figure
    switch (figur) {
      case 'GERADE':
        setWunschmassFields({ fields: 1, figur: 'I' })
        break
      case 'FIGUR L':
        setWunschmassFields({ fields: 2, figur: 'L' })
        break
      case 'FIGUR U':
        setWunschmassFields({ fields: 3, figur: 'U' })
        break
      case 'FIGUR Z':
        setWunschmassFields({ fields: 3, figur: 'Z' })
        break
      case 'RECHTECK QUADRAT':
        setWunschmassFields({ fields: 2, figur: 'O' })
        break
      default:
        setWunschmassFields({ fields: 1, figur: 'I' })
    }

    let params = Object.keys(options).map(key => ({
      label: key.toUpperCase(),
      value: options[key]
    }))

    params = params.filter(item => item.value)
    const fetchData = async () => {
      const response = await axios({
        url: '/api/biro40/getKep',
        method: 'POST',
        data: JSON.stringify(params),
        headers: {
          'content-type': 'application/json',
          Accept: 'application/json'
        }
      })
      const valuesNeeded = []
      Array.from({ length: wunschmassFields.fields }).forEach((_, index) => {
        const key = ('Schenkel' + wunschmassFields.figur + String.fromCharCode(65 + index)).toLowerCase()
        valuesNeeded.push(key)
      })

      // KEP Datensetzen
      if (response.data.length > 0) {
        setKep(response.data[0])

        let data = {
          Input_KEP_ID: response.data[0].kep_id,
          Input_PRO_BASE_ID: response.data[0].pro_base_id,
          Input_OPT_BASE_ID: response.data[0].opt_base_id,
          Input_GTR_BASE_ID: response.data[0].gtr_base_id,
          Input_KSED_ID: response.data[0].ksed_id,
          Input_VERB_ID: response.data[0].verb_id,
          Input_BEFE_ID: response.data[0].befe_id,
          Input_ESPE_ID: response.data[0].espe_id,
          Input_IA: getWunschmassOptions('schenkelia') ? getWunschmassOptions('schenkelia') : 860,
          Input_LA: getWunschmassOptions('schenkella') ? getWunschmassOptions('schenkella') : 1025,
          Input_LB: getWunschmassOptions('schenkellb') ? getWunschmassOptions('schenkellb') : 1025,
          Input_UA: getWunschmassOptions('schenkelua') ? getWunschmassOptions('schenkelua') : 1025,
          Input_UB: getWunschmassOptions('schenkelub') ? getWunschmassOptions('schenkelub') : 1200,
          Input_UC: getWunschmassOptions('schenkeluc') ? getWunschmassOptions('schenkeluc') : 1025,
          Input_ZA: getWunschmassOptions('schenkelza') ? getWunschmassOptions('schenkelza') : 1025,
          Input_ZB: getWunschmassOptions('schenkelzb') ? getWunschmassOptions('schenkelzb') : 1200,
          Input_ZC: getWunschmassOptions('schenkelzc') ? getWunschmassOptions('schenkelzc') : 1025,
          Input_OAC: getWunschmassOptions('schenkeloa') ? getWunschmassOptions('schenkeloa') : 1025,
          Input_OBD: getWunschmassOptions('schenkelob') ? getWunschmassOptions('schenkelob') : 1200
        }

        var result = calculateBiro40(data)
        var obj = JSON?.parse(result)

        switch (wunschmassFields.figur) {
          case 'I':
            if (obj['Output_JSON_I']) setOutput(JSON?.parse(obj['Output_JSON_I']))
            break
          case 'L':
            if (obj['Output_JSON_L']) setOutput(JSON?.parse(obj['Output_JSON_L']))
            break
          case 'U':
            if (obj['Output_JSON_U']) setOutput(JSON?.parse(obj['Output_JSON_U']))
            break
          case 'Z':
            if (obj['Output_JSON_Z']) setOutput(JSON?.parse(obj['Output_JSON_Z']))
            break
          case 'O':
            if (obj['Output_JSON_O']) setOutput(JSON?.parse(obj['Output_JSON_O']))
            break
          default:
            break
        }
      }
    }
    fetchData()
  }, [options, wunschmassFields.figur, wunschmassOptions, getChoice, getWunschmassOptions, setKep, setOutput])

  // Function to check if all LaengenOptions fields are filled
  const areAllLaengenOptionsFilled = () => {
    return Array.from({ length: wunschmassFields.fields }).every((_, index) => {
      const key = ('Schenkel' + wunschmassFields.figur + String.fromCharCode(65 + index)).toLowerCase()
      const value = getWunschmassOptions(key) || ''
      return String(value).trim() !== ''
    })
  }

  const isLVPositionVisible = isReadyForLaengenOptions && areAllLaengenOptionsFilled()

  const areAllFieldsFilled = () => {
    return areRequiredFieldsFilled(options) && areAllLaengenOptionsFilled()
  }

  const onAddHandler = () => {
    setShowTableDataGrid(true)
    setRefreshKey(prevKey => prevKey + 1)
  }

  const handleSearch = () => {
    const params = { id: searchId }
    const fetchData = async () => {
      try {
        const response = await axios({
          url: '/api/biro40/getSearch',
          method: 'POST',
          data: JSON.stringify(params),
          headers: {
            'content-type': 'application/json',
            Accept: 'application/json'
          }
        })

        console.log('Antwort erhalten:', response)

        if (!response.data || response.data.length === 0) {
          console.log('Fehler: Keine gültigen Daten in der Antwort')
          setOpenDialog(true)
          return
        }

        Object.entries(response.data[0]).forEach(([key, value]) => {
          console.log(`Setze ${key}:`, value)
          switch (key) {
            case 'ia':
              setWunschmassChoice('schenkelia', parseInt(value))
              break
            case 'la':
              setWunschmassChoice('schenkella', parseInt(value))
              break
            case 'lb':
              setWunschmassChoice('schenkellb', parseInt(value), 'from search')
              break
            case 'ua':
              setWunschmassChoice('schenkelua', parseInt(value), 'from search')
              break
            case 'ub':
              setWunschmassChoice('schenkelub', parseInt(value), 'from search')
              break
            case 'uc':
              setWunschmassChoice('schenkeluc', parseInt(value), 'from search')
              break
            case 'oa':
              setWunschmassChoice('schenkeloa', parseInt(value), 'from search')
              break
            case 'ob':
              setWunschmassChoice('schenkelob', value)
              break
            default:
              console.log(`Unbekannter Key: ${key}`)
          }
          setChoice(key, value)
        })
      } catch (error) {
        if (axios.isAxiosError(error)) {
          if (error.response) {
            if (error.response.status === 400) {
              console.error('Fehler 400 erkannt:', error.response.data)
              setOpenDialog(true)
            } else {
              console.error(`Fehler mit Status ${error.response.status}:`, error.response.data)
            }
          } else {
            console.error('Netzwerkfehler oder kein Response-Objekt:', error.message)
          }
        } else {
          console.error('Ein unerwarteter Fehler ist aufgetreten:', error)
        }
      }
    }
    fetchData()
  }

  return (
    <Fragment>
      <Card>
        <CardContent
          sx={{
            display: 'flex',
            justifyContent: 'center',
            flexDirection: 'column',
            gap: '25px'
          }}
        >
          {/* Main Grid Container */}
          <Grid container md={12} sx={{ alignItems: 'left', display: 'flex', justifyContent: 'space-between' }}>
            {/* Left Column */}
            <Grid xs={12} md={6} lg={9}>
              <Typography sx={{ fontWeight: '600', color: '#000', fontSize: '18px', mb: 1 }}>
                Parameter Eingabe
              </Typography>
              <Typography sx={{ fontWeight: '500', fontSize: '17px', mb: 2 }}>
                Bitte wählen Sie die Parameter aus:
              </Typography>
              {/* Display Dropdown Options */}
              <Grid container spacing={2} alignItems='center'>
                {/* Left Column - First 3 Options */}
                <Grid item xs={6} display='flex' flexDirection='column' gap={2}>
                  <FigurOptions label='Figur' isDropDown={true} fullWidth />
                  <MontageOptions label='Montageart' isDropDown={true} fullWidth />
                  <GehaeusefarbeOptions label='Gehäusefarbe' isDropDown={true} fullWidth />
                </Grid>
                {/* Right Column - Next 3 Options */}
                <Grid item xs={6} display='flex' flexDirection='column' gap={2}>
                  <LichtfarbeOptions label='Lichtfarbe' isDropDown={true} fullWidth />
                  <AnsteuerungOptions label='Ansteuerung' isDropDown={true} fullWidth />
                  <OptikOptions label='Optisches System' isDropDown={true} fullWidth />
                </Grid>
              </Grid>

              <Divider
                orientation='horizontal'
                flexItem
                sx={{
                  border: '1.2px solid #ccc',
                  mx: 2,
                  opacity: '0.5',
                  mt: 10,
                  mb: 10
                }}
              />

              {/* Render Wunschmass Fields only if the first six fields are filled */}
              {isReadyForLaengenOptions &&
                Array.from({ length: wunschmassFields.fields }).map((_, index) => (
                  <LaengenOptions
                    key={index}
                    label={`Schenkel ${wunschmassFields.figur + String.fromCharCode(65 + index)}`}
                    isDropDown={true}
                    schenkel={wunschmassFields.figur + String.fromCharCode(65 + index)}
                    basismass={getKep('min')}
                  />
                ))}
              {isLVPositionVisible && <LVPosition label='LV Position' />}

              {/* Button und Suchfeld */}
              <Box sx={{ mt: 4, display: 'flex', flexDirection: 'row', alignItems: 'center' }}>
                <Button
                  disabled={!areAllFieldsFilled()}
                  onClick={onAddHandler}
                  size='large'
                  type='submit'
                  sx={{ mr: 2 }}
                  variant='contained'
                >
                  <Translations text={'Konfiguration hinzufügen'} />
                </Button>
                <Input
                  placeholder='Konfigurations-ID'
                  sx={{ mb: 2, ml: 30 }}
                  value={searchId}
                  onChange={e => setSearchId(e.target.value)}
                />
                <Button onClick={handleSearch} sx={{ ml: 2 }} variant='contained'>
                  Suchen
                </Button>
              </Box>
            </Grid>

            {/* Right Column */}
            <Grid xs={12} md={6} lg={3} sx={{ p: 2 }}>
              <Box
                sx={{
                  display: 'grid',
                  gridTemplateColumns: { xs: 'repeat(1, 1fr)', sm: 'repeat(2, 1fr)' },
                  gap: 2
                }}
              >
                <Box
                  sx={{
                    width: { xs: '100%', sm: 250 },
                    height: { xs: 'auto', sm: 250 },
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    boxShadow: '4px 4px 10px rgba(0, 0, 0, 0.3)',
                    border: '4px solid rgba(45, 45, 45, 0.3)'
                  }}
                >
                  <img
                    src={`/images/konfigurator/biro40/svg/${getKep('svg_image')}`}
                    alt='SVG Bild'
                    style={{
                      maxWidth: '100%',
                      maxHeight: '100%',
                      objectFit: 'contain'
                    }}
                  />
                </Box>
                <Box
                  sx={{
                    width: { xs: '100%', sm: 250 },
                    height: { xs: 'auto', sm: 250 },
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    boxShadow: '4px 4px 10px rgba(0, 0, 0, 0.3)',
                    border: '4px solid rgba(45, 45, 45, 0.3)'
                  }}
                >
                  <img
                    src={`/images/konfigurator/biro40/produktbilder/${getKep('produktbild')}`}
                    alt='Produktbild'
                    style={{
                      width: '100%',
                      height: '100%',
                      objectFit: 'contain'
                    }}
                  />
                </Box>
                <Box
                  sx={{
                    width: { xs: '100%', sm: 250 },
                    height: { xs: 'auto', sm: 250 },
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    boxShadow: '4px 4px 10px rgba(0, 0, 0, 0.3)',
                    border: '4px solid rgba(45, 45, 45, 0.3)'
                  }}
                >
                  <img
                    src={`/images/konfigurator/biro40/figur/${getKep('skizze')}`}
                    alt='Skizze'
                    style={{
                      maxWidth: '100%',
                      maxHeight: '100%',
                      objectFit: 'contain'
                    }}
                  />
                </Box>
                <Box
                  sx={{
                    width: { xs: '100%', sm: 250 },
                    height: { xs: 'auto', sm: 250 },
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    boxShadow: '4px 4px 10px rgba(0, 0, 0, 0.3)',
                    border: '4px solid rgba(45, 45, 45, 0.3)'
                  }}
                >
                  <img
                    src={`/images/konfigurator/biro40/polar/${getKep('polardiagramm')}`}
                    alt='Polar Diagramm'
                    style={{
                      maxWidth: '100%',
                      maxHeight: '100%',
                      objectFit: 'contain'
                    }}
                  />
                </Box>
              </Box>
            </Grid>
          </Grid>
          {showTableDataGrid && <TableDataGridBir040 refreshKey={refreshKey} />}
        </CardContent>
      </Card>
      <AlertDialogSlide open={openDialog} setOpen={setOpenDialog} />
    </Fragment>
  )
}

export default Biro40Form
