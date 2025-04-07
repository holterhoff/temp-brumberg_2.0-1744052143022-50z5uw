// ** Next Import
import Link from 'next/link'

// ** MUI Imports
import Box from '@mui/material/Box'
import Typography from '@mui/material/Typography'
import { styled, useTheme } from '@mui/material/styles'

// ** Theme Config Import
import themeConfig from 'src/configs/themeConfig'

const LinkStyled = styled(Box)(({ theme }) => ({
  display: 'flex',
  alignItems: 'center',
  textDecoration: 'none',
  marginRight: theme.spacing(8)
}))

const AppBarContent = props => {
  // ** Props
  const { appBarContent: userAppBarContent, appBarBranding: userAppBarBranding } = props

  // ** Hooks
  const theme = useTheme()

  return (
    <Box sx={{ width: '100%', display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
      {userAppBarBranding ? (
        userAppBarBranding(props)
      ) : (
        <LinkStyled href='/'>
          {/* <svg width={40} fill='none' height={22} viewBox='0 0 268 150' xmlns='http://www.w3.org/2000/svg'> */}
          {/* Brumberg Logo */}
          <svg height={30} width={220} xmlns='http://www.w3.org/2000/svg'>
            <g transform='translate(-147 -38)'>
              <path
                d='M152.2,42.8v6.7h2.2c4,0,5.4-0.9,5.4-3.4c0-2.6-1.3-3.3-5.7-3.3H152.2 M152.2,53.7v7.9h2.3c5.3,0,6.6-0.8,6.6-3.9
		c0-3.1-1.5-4-6.5-4L152.2,53.7 M153.5,65.8H147V38.5h7.3c3.2,0,4.9,0.2,6.3,0.7c2.6,0.9,4.4,3.4,4.3,6.2c0,3-1.3,4.8-4.4,5.8
		c4,0.9,5.9,3.2,5.9,6.8c0.1,3.2-2,6.1-5,7.2C159.4,65.7,158.3,65.8,153.5,65.8'
              />
              <path
                d='M176.2,43v7.9h1.9c5.1,0,6.8-1,6.8-4c0-1.3-0.6-2.5-1.8-3.2c-1.1-0.6-1.9-0.7-5.4-0.7L176.2,43 M191.6,65.8h-6.1L180,55.4
		h-3.8v10.4h-5.2V38.5h6.8c4.8,0,6.7,0.3,8.5,1.3c2.5,1.5,4,4.2,3.9,7.1c0.2,3.3-1.8,6.3-4.8,7.6L191.6,65.8'
              />
              <path
                d='M205.5,66.3c-4.6,0-8.1-1.8-9.7-5.1c-0.9-1.7-1.1-3-1.1-7V38.5h5.3v15.7c0,3.3,0.1,4.3,0.9,5.5c1.1,1.5,2.8,2.3,4.6,2.1
		c3.2,0,5.2-1.7,5.4-4.7c0.1-1,0.1-2,0.1-3V38.5h5.2v15.7c0,4-0.2,5.3-1.1,7C213.7,64.5,210,66.3,205.5,66.3'
              />
              <path d='M248.5,65.8h-4.7V44.5L238,65.8h-5.4l-5.7-21.3v21.3h-4.7V38.5h7.3l5.9,21.7l5.9-21.7h7.2V65.8z' />
              <path
                d='M259.9,42.8v6.7h2.2c4,0,5.4-0.9,5.4-3.4c0-2.6-1.3-3.3-5.7-3.3H259.9 M259.9,53.7v7.9h2.3c5.3,0,6.6-0.8,6.6-3.9
		c0-3.1-1.5-4-6.5-4L259.9,53.7 M261.2,65.8h-6.5V38.5h7.3c3.2,0,4.9,0.2,6.3,0.7c2.6,0.9,4.4,3.4,4.3,6.2c0,3-1.3,4.8-4.4,5.8
		c4,0.9,5.9,3.2,5.9,6.8c0.1,3.2-2,6.1-5,7.2C267.2,65.7,266,65.8,261.2,65.8'
              />
              <path d='M296.4,65.8h-17.6V38.5h17.1V43H284v6.4h10.8v4.4H284v7.4h12.4V65.8z' />
              <path
                d='M306.8,43v7.9h1.9c5.1,0,6.7-1,6.7-4c0-1.3-0.6-2.5-1.8-3.2c-1.1-0.6-1.9-0.7-5.4-0.7L306.8,43 M322.2,65.8h-6.1l-5.6-10.4
		h-3.8v10.4h-5.2V38.5h6.8c4.8,0,6.7,0.3,8.5,1.3c2.5,1.5,4,4.2,3.9,7.1c0.2,3.3-1.8,6.3-4.8,7.6L322.2,65.8'
              />
              <path
                d='M337,66.3c-7.7,0-12.6-5.4-12.6-14.1c0-8.6,4.8-14.3,12.2-14.3c6,0,9.7,3.5,10,9.3h-4.5c-0.5-3.2-2.2-4.8-5.4-4.8
		c-4.3,0-6.8,3.6-6.8,9.7s2.6,9.6,7.1,9.6c2,0,4-0.7,5.7-1.8v-4.4h-5.5v-3.9h9.7v11.3C344.1,65.2,340.6,66.4,337,66.3'
              />
            </g>
          </svg>
          <Typography variant='h6' sx={{ ml: 2, fontWeight: 700, lineHeight: 1.2 }}>
            {themeConfig.templateName}
          </Typography>
        </LinkStyled>
      )}
      {userAppBarContent ? userAppBarContent(props) : null}
    </Box>
  )
}

export default AppBarContent
