const BandModel = require('../models/band_model');
class BandsModel {
    constructor() {
        this.bands = [];
    }

    addBand(band = new BandModel()) {
        this.bands.push(band);
    }
    getBands() {
        return this.bands;
    }

    deleteBand(id = '') {
        this.bands = this.bands.filter(b => b.id !== id);
        return this.bands;
    }

    voteBand(id = '') {
        this.bands.map(band => {
            if (band.id === id) {
                band.votes++;
                return band;
            } else {
                return band
            }
        });
    }
}

module.exports = BandsModel;