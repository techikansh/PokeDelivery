const axios = require('axios');

module.exports = async function (context, req) {
    const name = req.query.name || 'pikachu';

    // Mapping of Pokémon types to their favorite sushi
    const sushiPreferences = {
        electric: 'Salmon',
        fire: 'Tuna',
        water: 'Mackerel',
        grass: 'Avocado Roll',
        psychic: 'Tamago',
        rock: 'Cucumber',
        ground: 'Daikon',
        ice: 'Surimi',
        dragon: 'Unagi',
        dark: 'Squid',
        fairy: 'Strawberry Mochi',
        bug: 'Edamame',
        poison: 'Wasabi',
        ghost: 'Ghost Algae',
        steel: 'Sesame Roll',
        fighting: 'Protein Roll',
        flying: 'Airy Rice Ball',
        normal: 'Classic Nigiri'
    };

    try {
        const response = await axios.get(`https://pokeapi.co/api/v2/pokemon/${name}`);
        const data = response.data;

        const types = data.types.map(t => t.type.name);
        const favoriteFood = sushiPreferences[types[0]] || 'Maki Roll';

        const result = {
            name: data.name,
            id: data.id,
            height: data.height,
            weight: data.weight,
            base_experience: data.base_experience,
            types: types,
            favoriteFood: favoriteFood
        };

        context.res = {
            status: 200,
            body: result
        };
    } catch (err) {
        context.res = {
            status: 500,
            body: `Error: ${err.message}`
        };
    }
};
