// ** MUI Imports
import Grid from '@mui/material/Grid'

// ** Demo Components Imports

import KonfigViewLeft from 'src/views/konfigurator/view/KonfigViewLeft'
import KonfigViewRight from 'src/views/konfigurator/view/KonfigViewRight'

const KonfigView = ({ id, tab, konfigData }) => {
  return (
    <Grid container spacing={6}>
      <Grid item xs={12} md={5} lg={4}>
        <KonfigViewLeft />
      </Grid>
      <Grid item xs={12} md={7} lg={8}>
        <KonfigViewRight id={id} tab={tab} konfigData={konfigData} />
      </Grid>
    </Grid>
  )
}

export default KonfigView
