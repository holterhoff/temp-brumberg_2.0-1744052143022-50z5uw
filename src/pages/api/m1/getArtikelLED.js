'use server'

import { neon } from '@neondatabase/serverless'

const sql = neon(process.env.DATABASE_URL)
export default async function getArtikelLED(req, res) {
  if (req.method == 'POST') {
    let params = JSON.parse(req.body)

    let query = `

      SELECT DISTINCT
      1 as Position,
      ${params.A_Menge_LED} as Menge,
      bezeichnung_led_de as Bezeichnung,
      typ_led as Typ,
      artikelnummer_led as Artikelnummer,
      datenblatt_led_de as Datenblatt,
      preis_led as Preis

      FROM m1
      WHERE artikelnummer_led = '${params.E_Artikelnummer_LED}'

    `

    query += 'order by 1'

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
