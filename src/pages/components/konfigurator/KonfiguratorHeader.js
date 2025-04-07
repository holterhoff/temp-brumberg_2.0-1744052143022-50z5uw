// ** React Imports
import { useState, useEffect } from 'react'

// ** MUI Components
import Box from '@mui/material/Box'
import Card from '@mui/material/Card'
import Button from '@mui/material/Button'
import { styled } from '@mui/material/styles'
import CardMedia from '@mui/material/CardMedia'
import Typography from '@mui/material/Typography'
import Translations from 'src/layouts/components/Translations'
import CardContent from '@mui/material/CardContent'

// ** Third Party Imports
import axios from 'axios'

// ** Icon Imports
import Icon from 'src/@core/components/icon'
import { margin } from '@mui/system'
import { bg } from 'date-fns/locale'

const ProfilePicture = styled('img')(({ theme }) => ({
  width: 120,
  height: 120,
  borderRadius: theme.shape.borderRadius,
  border: `5px solid ${theme.palette.common.white}`,
  [theme.breakpoints.down('md')]: {
    marginBottom: theme.spacing(4)
  }
}))

const KonfiguratorHeader = props => {
  // ** State
  const [data, setData] = useState(null)

  useEffect(() => {
    axios.get('/pages/profile-header').then(response => {
      setData(response.data)
    })
  }, [])

  const designationIcon = data?.designationIcon || 'mdi:briefcase-outline'

  return data !== null ? (
    <Card sx={{ bgcolor: 'primary.main' }}>
      <CardMedia
        component='img'
        alt='profile-header'
        image={props.titleImage}
        // image={data.coverImg}
        sx={{
          height: { xs: 100, md: '80%' },
          mb: 2
        }}
      />
    </Card>
  ) : null
}

export default KonfiguratorHeader
