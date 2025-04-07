import query from '../dbservice'

export default async function getKonfigurationbyId(req, res) {
  if (req.method == 'GET') {
    let sql = "SELECT * FROM fakt.m1 WHERE id = '" + req.query.id + "'"

    sql += ' ORDER BY 1'

    const result = await query(sql)

    if (result) {
      res.status(200).json(result)
    } else {
      res.status(500).json({ message: 'Fehler beim Login' })
    }
  } else {
    res.status(401).json({ message: 'This Methode not allowed' })
  }
}
