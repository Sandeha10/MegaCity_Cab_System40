document.addEventListener("DOMContentLoaded", function () {
    const vehicleType = document.getElementById("vehicleType");
    const vehicleDetails = document.getElementById("vehicleDetails");
    const vehicleModel = document.getElementById("vehicleModel");

    vehicleType.addEventListener("change", function () {
        const selectedType = vehicleType.value;
        vehicleDetails.style.display = selectedType ? "block" : "none";
        vehicleModel.innerHTML = '';

        if (selectedType === 'car') {
            const carModels = ['Wagon R', 'Aqua', 'Vezel'];
            carModels.forEach(function (model) {
                let option = document.createElement("option");
                option.value = model;
                option.textContent = model;
                vehicleModel.appendChild(option);
            });
        } else if (selectedType === 'van') {
            const vanModels = ['KDH', 'Suzuki Every'];
            vanModels.forEach(function (model) {
                let option = document.createElement("option");
                option.value = model;
                option.textContent = model;
                vehicleModel.appendChild(option);
            });
        }
    });

    // NIC Validation
    const nicField = document.getElementById("nic");
    const nicError = document.getElementById("nicError");
    nicField.addEventListener("input", function () {
        if (nicField.value.length !== 12) {
            nicError.style.display = "inline";
        } else {
            nicError.style.display = "none";
        }
    });
});
