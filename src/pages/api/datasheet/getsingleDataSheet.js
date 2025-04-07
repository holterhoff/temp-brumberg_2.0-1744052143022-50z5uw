import query from '../dbservice'

export default async function getSingleDataSheet(req, res) {
  if (req.method == 'GET') {
    let sql = "SELECT top 10 * FROM fakt.spot WHERE 1=1 AND ID ='" + req.query.id + "'"

    const data = await query(sql)

    if (data) {
      res.status(200).json(data[0])
    } else {
      res.status(500).json({ message: 'Fehler beim Login' })
    }
  } else {
    res.status(401).json({ message: 'This Methode not allowed' })
  }
}
