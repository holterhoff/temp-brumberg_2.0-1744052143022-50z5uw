import query from '../dbservice'
import jwt from 'jsonwebtoken';

const jwtConfig = {
  secret: 'dd5f3089-40c3-403d-af14-d0c228b05cb4',
  refreshTokenSecret: '7c4c1c50-3230-45bf-9eae-c9b2e401c767'
}

export default async function register(req, res) {


    res.status(500).json({message:'Fehler beim Login'})

 }


