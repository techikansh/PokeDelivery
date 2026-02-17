const getPokemon = require('./index');

const context = {
    res: null
};

const req = {
    query: {
        name: 'bulbasaur'
    }
};

getPokemon(context, req).then(() => {
    console.log('Response:', context.res);
}).catch(err => {
    console.error('Error:', err);
});
