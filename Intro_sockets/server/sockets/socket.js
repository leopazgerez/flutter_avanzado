const { io } = require('../index');
const BandsModel = require('../models/bands_model');
const BandModel = require('../models/band_model');

const bands = new BandsModel();
bands.addBand(new BandModel('Queen'));
bands.addBand(new BandModel('Bon Jovi'));
bands.addBand(new BandModel('Héroes del Silencio'));
bands.addBand(new BandModel('Metallica'));
// Mensajes de Sockets

io.on('connection', client => {
    console.log('cliente conectado')

    client.emit('active-bands', bands.getBands());
    client.on('disconnect', () => { console.log('cliente desconectado') });
    // client.on('active-bands', (data) => {
    //     console.log(data)
    //     io.emit('data', { admin: 'Nuevo mensaje' });
    // });
    client.on('new-event', (payload) => {
        console.table(payload);
        client.broadcast.emit('new-event', payload);//emite a todos excepto al que lo crea

    });
    client.on('vote-band', (payload) => {
        bands.voteBand(payload['id']);
        console.table(payload);
        io.emit('active-bands', bands.getBands());
        // client.broadcast.emit('vote-band', payload);
        //emite a todos excepto al que lo crea

    });
    client.on('add-band', (payload) => {
        bands.addBand(BandModel.fromMap(payload));
        console.table(payload);
        io.emit('active-bands', bands.getBands());
        // client.broadcast.emit('vote-band', payload);
        //emite a todos excepto al que lo crea

    });

    client.on('delete-band', (payload) => {
        bands.deleteBand(payload.id);
        console.table(payload);
        io.emit('active-bands', bands.getBands());
        // client.broadcast.emit('vote-band', payload);
        //emite a todos excepto al que lo crea

    });
});