'use server'

import { neon } from '@neondatabase/serverless'

const sql = neon(process.env.DATABASE_URL)

export default async function getArtikelGehaeuse(req, res) {
  if (req.method == 'POST') {
    let params = JSON.parse(req.body)

    let query = `
      SELECT DISTINCT
      position = 0,
      menge = ${params.A_Menge_Gehaeuse},
      bezeichnung_gehaeuse_de as Bezeichnung,
      typ_gehaeuse_de as Typ,
      artikelnummer_gehaeuse as Artikelnummer,
      datenblatt_gehaeuse_de as Datenblatt,
      preis_gehaeuse as Preis

      FROM spot
      where artikelnummer_gehaeuse = ${params.E_Artikelnummer_Gehaeuse}
    `

    query += ' ORDER BY 1'

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
