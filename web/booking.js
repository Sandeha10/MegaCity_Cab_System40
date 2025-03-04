document.addEventListener("DOMContentLoaded", function() {
    const vehicleRates = {
        Car: { "Alto": 100, "Aqua": 150, "Vezel": 200 },
        Van: { "Suzuki Every": 300, "KDH": 400 }
    };

    const distances = {
        "Matara-Weligama": 15,
        "Matara-Galle": 40,
        "Weligama-Galle": 25
    };

    document.getElementById("drop").addEventListener("change", function() {
        const pickup = document.getElementById("pickup").value;
        const drop = document.getElementById("drop").value;
        document.getElementById("distance").value = distances[`${pickup}-${drop}`] || distances[`${drop}-${pickup}`] || 0;
    });

    document.getElementById("vehicleType").addEventListener("change", function() {
        const type = this.value;
        const vehicleSelect = document.getElementById("vehicleName");
        vehicleSelect.innerHTML = "";
        Object.keys(vehicleRates[type] || {}).forEach(vehicle => {
            vehicleSelect.innerHTML += `<option value="${vehicle}">${vehicle}</option>`;
        });
    });

    document.getElementById("vehicleName").addEventListener("change", function() {
        const type = document.getElementById("vehicleType").value;
        const vehicle = this.value;
        const rate = vehicleRates[type][vehicle];
        const distance = document.getElementById("distance").value;
        const fare = (rate * distance) * 1.1; // 10% tax
        document.getElementById("fare").value = fare.toFixed(2);
    });

    document.getElementById("nic").addEventListener("input", function() {
        if (!/^\d{12}$/.test(this.value)) {
            document.getElementById("nicError").textContent = "NIC must be exactly 12 digits.";
        } else {
            document.getElementById("nicError").textContent = "";
        }
    });

    document.getElementById("contact").addEventListener("input", function() {
        if (!/^\d{10}$/.test(this.value)) {
            document.getElementById("contactError").textContent = "Contact must be 10 digits.";
        } else {
            document.getElementById("contactError").textContent = "";
        }
    });
});
