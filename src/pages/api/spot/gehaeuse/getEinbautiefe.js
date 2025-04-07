'use server'

import { neon } from '@neondatabase/serverless'

const sql = neon(process.env.DATABASE_URL)
export default async function getEinbautiefe(req, res) {
  if (req.method == 'POST') {
    let params = JSON.parse(req.body)

    let query = 'SELECT DISTINCT einbautiefe as value_de, einbautiefe as value_en FROM spot  WHERE 1=1 '

    params.forEach(element => {
      if (element.label == 'Form') {
        let form = element.value
        query += " AND (form_de = '" + form + "' OR form_en = '" + form + "')"
      }
    })

    query += ' ORDER BY 1 DESC'

    const result = await sql(query)

    if (result) {
      res.status(200).json(result)
    } else {
      res.status(500).json({ message: 'Fehler beim Login' })
    }
  } else {
    res.status(401).json({ message: 'This Methode not allowed' })
  }
}
