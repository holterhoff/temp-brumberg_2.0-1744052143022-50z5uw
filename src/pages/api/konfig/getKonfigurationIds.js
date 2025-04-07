import query from '../dbservice'

export default async function getKonfigurationIds(req, res) {
  if (req.method == 'GET') {
    // let sql = "SELECT CAST(REPLACE(id,'-','')as INT) AS id FROM fakt.m1 "
    let sql = 'SELECT id FROM fakt.m1 '

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
