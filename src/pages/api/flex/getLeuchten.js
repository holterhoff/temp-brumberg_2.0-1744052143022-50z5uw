import query from '../dbservice'

export default async function getLeuchten(req, res) {
  if(req.method == 'POST'){

   let sql = "SELECT DISTINCT Leuchtentyp as [value] FROM test " ;

   const result = await query(sql)

  if (result) {
    res.status(200).json(result)
  }else {

    res.status(500).json({message:'Fehler beim Login'})

  }
 }else {

    res.status(401).json({message: 'This Methode not allowed'})

 }
}
