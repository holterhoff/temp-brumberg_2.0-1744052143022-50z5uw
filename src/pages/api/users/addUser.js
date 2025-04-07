import query from '../dbservice'
import sql from 'mssql';


export default async function addUser(req, res) {
 if(req.method == 'POST'){

  const request = new sql.Request()

  request.input('fullname', sql.VarChar, req.body.data.fullName)
  request.input('street', sql.VarChar, req.body.data.street)
  request.input('zip', sql.VarChar, req.body.data.zip)
  request.input('city', sql.VarChar, req.body.data.city)
  request.input('country', sql.VarChar, req.body.data.country)
  request.input('phone', sql.VarChar, req.body.data.phone)

  //request.input('fax', sql.VarChar, req.body.data.fax)
  request.input('email', sql.VarChar, req.body.data.email)
  request.input('role', sql.VarChar, req.body.data.role)

  //request.input('web', sql.VarChar, req.body.data.web)
  request.input('password', sql.VarChar, req.body.data.password)

  request.input('avatar', sql.VarChar, req.body.data.avatar)

  //request.input('logo', sql.VarChar, req.body.data.logo)
  request.input('status', sql.VarChar, req.body.data.status)

  //request.input('language', sql.VarChar, req.body.data.language)
  request.input('expireDate', sql.VarChar, req.body.data.expireDate)
  request.input('factor', sql.VarChar, req.body.data.factor)
  request.input('tax', sql.Numeric, req.body.data.tax)


  request.query('INSERT into [dbo].[users] (fullName, street, zip, city, country, phone, email, role, password, factor, tax, avatar, status, expireDate ) VALUES (@fullName, @street, @zip, @city, @country, @phone, @email, @role, @password, @factor, @tax, @avatar, @status, @expireDate)'), (result, err) => {
    console.log(result)




  }

  if (true) {
      res.status(200).json('User Added')
    }else {

      res.status(500).json({message:'Fehler beim Login'})
    }


 }else {

    res.status(401).json({message: 'This Methode not allowed'})

 }
}
