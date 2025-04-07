'use server'

import { neon } from '@neondatabase/serverless'

const sql = neon(process.env.DATABASE_URL)

export default async function getGehaeusefarbe(req, res) {
  if (req.method == 'POST') {
    let params = JSON.parse(req.body)

    let sql = 'SELECT DISTINCT farbe_de as value_de, farbe_en as value_en FROM Spot  WHERE 1=1 '

    params.forEach(element => {
      if (element.label == 'Form') {
        let form = element.value
        query += " AND (form_de = '" + form + "' OR form_en = '" + form + "')"
      }
      if (element.label == 'Einbautiefe') {
        let einbautiefe = element.value
        query += " AND einbautiefe = '" + einbautiefe + "'"
      }
    })

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
