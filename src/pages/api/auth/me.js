import query from '../dbservice'
import jwt from 'jsonwebtoken';
import { esES } from '@mui/material/locale';

const jwtConfig = {
  secret: 'dd5f3089-40c3-403d-af14-d0c228b05cb4',
  refreshTokenSecret: '7c4c1c50-3230-45bf-9eae-c9b2e401c767'
}

export default async function authMe(req, res) {


  if(req.method == 'GET'){
    const {email, password } = req.body
    const sql ='SELECT * FROM dbo.[users]'
    const result = await query(sql)

    //@ts-ignore
    const token = req.headers.authorization

    // // get the decoded payload and header
    const decoded = jwt.decode(token, { complete: true })

    if (decoded) {
      // @ts-ignore
      const { id: userId } = decoded.payload
      const userData = result.find(u => u.id === userId)
      delete userData.password

      res.status(200).json({ userData })
    } else {
      res.status(401).json({ error: 'Invalid User' })
    }

  } else {

    res.status(401).json({message: 'This Methode not allowed'})
  }

}
