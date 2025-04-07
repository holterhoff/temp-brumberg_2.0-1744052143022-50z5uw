import sql from 'mssql';

// generate config for mssql connection


const sqlConfig = {
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_DATABASE,
  server: process.env.DB_HOST,
  port: 53341,
  pool: {
    max: 10,
    min: 0,
    idleTimeoutMillis: 30000
  },
  options: {
    encrypt: false, // for azure
    trustServerCertificate: false // change to true for local dev / self-signed certs
  }
}


const query = async (query) => {
 try {
  // make sure that any items are correctly URL encoded in the connection string
  await sql.connect(sqlConfig)

  // const result = await sql.query`select * from mytable where id = ${value}`
  const result = await sql.query(query)


    return result.recordset

 } catch (err) {
    console.log(err)
 }
}


export default query;
