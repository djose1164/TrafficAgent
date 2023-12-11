const estimatedSize = 1000000;

function handle() {
    let db;
    try {
        db = LocalStorage.openDatabaseSync("TrafficTicketDB", "", "A database for handling traffic tickets", estimatedSize);
    } catch(e) {
        print("Failed to open the database: " + e);
    }
    return db;
}

function init() {
    try {
        const db = handle();
        const query = `CREATE TABLE IF NOT EXISTS traffic_tickets (
            cedula TEXT UNIQUE,
            license_plate TEXT UNIQUE,
            motive_id INT NOT NULL,
            picture TEXT,
            voice_note TEXT,
            commentary TEXT,
            latitude REAL,
            longitude REAL,
            date_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        )`;

        db.transaction(function(tx) {
            tx.executeSql(query);
        });
    } catch(e) {
        print("Failed to initialize the databse: " + e);
        Qt.quit();
    }
}

function insert({cedula, licensePlate, motiveId, picture, voiceNote, latitude, longitude, commentary}) {
    const db = handle();
    const query = `
        INSERT INTO traffic_tickets(cedula, license_plate, motive_id, picture, voice_note, commentary, latitude, longitude)
        VALUES(?, ?, ?, ?, ?, ?, ?, ?)
    `;
    let rowId;

    db.transaction(function(tx) {
        const r = tx.executeSql(query,
            [cedula, licensePlate, motiveId, picture, voiceNote, commentary, latitude, longitude]);
        rowId = r.insertId;
    });

    return rowId;
}

function getAll() {
    const db = handle();
    const query = "SELECT rowid, * FROM traffic_tickets"
    const fetched = [];

    db.transaction(function(tx) {
        const rs = tx.executeSql(query);

        for (let i = 0; i < rs.rows.length; ++i) {
            fetched.push({
                rowId: rs.rows.item(i).rowid,
                cedula: rs.rows.item(i).cedula,
                licensePlate: rs.rows.item(i).license_plate,
                motiveId: rs.rows.item(i).motive_id,
                picture: rs.rows.item(i).picture,
                voiceNote: rs.rows.item(i).voice_note,
                commentary: rs.rows.item(i).commentary,
                latitude: rs.rows.item(i).latitude,
                longitude: rs.rows.item(i).longitude,
                dateTime: rs.rows.item(i).date_time
            });
            print(JSON.stringify(fetched, null, 2))
        }
    });

    return fetched;
}

function deleteAll() {
    const db = handle();
    const query = "DELETE FROM traffic_tickets";

    db.transaction(function(tx) {
        tx.executeSql(query);
    });
}
