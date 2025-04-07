'use server'

import { neon } from '@neondatabase/serverless'

const sql = neon(process.env.DATABASE_URL)

export default async function getImageTreiber(req, res) {
  if (req.method == 'POST') {
    let params = JSON.parse(req.body)
    let query = 'SELECT DISTINCT treiber_image as value FROM spot WHERE 1=1 '
    let treiber = ''
    let ansteuerung = ''
    let ausfuehrung = ''

    params.forEach(element => {
      if (element.label == 'Treiber') {
        let treiber = element.value
        query += " AND (treiber_de = '" + treiber + "' OR treiber_en = '" + treiber + "')"
      }

      if (element.label == 'Ansteuerung') {
        let ansteuerung = element.value
        query += " AND (ansteuerung2_de = '" + ansteuerung + "' OR ansteuerung2_en = '" + ansteuerung + "')"
      }

      if (element.label == 'Anschlussleitung') {
        let ausfuehrung = element.value
        query += " AND (ausfuehrung_de = '" + ausfuehrung + "' OR ausfuehrung_en = '" + ausfuehrung + "')"
      }
    })

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
