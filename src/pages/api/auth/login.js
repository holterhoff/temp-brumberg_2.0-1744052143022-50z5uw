import query from '../dbservice'
import jwt from 'jsonwebtoken';

const jwtConfig = {
  secret: 'dd5f3089-40c3-403d-af14-d0c228b05cb4',
  refreshTokenSecret: '7c4c1c50-3230-45bf-9eae-c9b2e401c767'
}

export default async function login(req, res) {

   if(req.method == 'POST'){

   const {email, password } = req.body
   const sql ='SELECT * FROM dbo.[users]'
   const result = await query(sql)
   const user = result.find(u => u.email === email && u.password === password)

  if (user) {
    const accessToken = jwt.sign({ id: user.id }, jwtConfig.secret)

    const response = {
      accessToken,
      userData: { ...user, password: undefined }
    }

    res.status(200).json(response)
  }else {

    res.status(500).json({message:'Fehler beim Login'})

  }
 }else {

    res.status(401).json({message: 'This Methode not allowed'})

 }
}


