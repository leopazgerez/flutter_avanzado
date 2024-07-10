const { v4: uuidV4 } = require('uuid');

class BandModel {
    constructor(name = 'no-name') {
        this.id = uuidV4();
        this.name = name;
        this.votes = 0;
    }


    static fromMap(map) {
        return new BandModel(map.name);
    }
}
module.exports = BandModel;
