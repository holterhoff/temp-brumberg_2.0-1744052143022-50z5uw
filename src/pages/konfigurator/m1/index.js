// ** MUI Imports
import Grid from '@mui/material/Grid'

import M1Form from 'src/views/konfigurator/m1/M1Form'
import KonfiguratorHeader from 'src/pages/components/konfigurator/KonfiguratorHeader'
import { useAuth } from 'src/hooks/useAuth'

const M1View = ({ tab, invoiceData }) => {
  const auth = useAuth()

  return (
    <Grid container spacing={6}>
      <Grid item xs={12}>
        <KonfiguratorHeader
          modul={'M1 Modulsystem'}
          subText={'In drei Schritten zur individuellen Leuchte.'}
          profileImage={'/images/konfigurator/45029180.jpg'}
          titleImage={'https://www.brumberg.com/fileadmin/mediafiles/_processed_/e/5/csm_M1_Head_c2619694f3.jpg'}
        />
      </Grid>

      <Grid item xs={12} md={12} lg={12}>
        <M1Form />
      </Grid>
    </Grid>
  )
}

M1View.guestGuard = true

export default M1View
