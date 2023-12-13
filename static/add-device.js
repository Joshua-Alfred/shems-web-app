// static/add-device.js
document.addEventListener('DOMContentLoaded', () => {
    document.body.addEventListener('change', (event) => {
        if (event.target.classList.contains('device-type')) {
            const type = event.target.value;
            const modelSelect = event.target.closest('.device-form').querySelector('.model-name');
            updateModelOptions(modelSelect, type);
        }
    });
});

function updateModelOptions(modelSelect, type) {
    const models = {
        'Refrigerator': ['Onida 6789 Super', 'Samsung 8000 Dual Cool', 'Model X'],
        'Light Bulb': ['Havells 4323', 'Phillips 5643'],
        'Dryer': ['IBM 1901', 'Whirlpool 45 Dryer'],
        'Washer': ['Whirlpool Oni'],
        'Television': ['Samsung CurveLED 4321'],
        'Heater': ['Honeywell Thermos 121']
    };

    // Clear existing options
    modelSelect.innerHTML = '';
    modelSelect.appendChild(new Option('Select Model', ''));

    // Populate model options based on the type
    if (models[type]) {
        models[type].forEach((model) => {
            modelSelect.appendChild(new Option(model, model));
        });
    }
}
