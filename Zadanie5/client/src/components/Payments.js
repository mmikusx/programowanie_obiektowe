import React, { useState, useContext } from 'react';
import { OrderContext } from '../OrderContext';

function Payments() {
    const [status, setStatus] = useState('nieopłacone');
    const [orderItems, , , services] = useContext(OrderContext);

    const handlePayment = () => {
        fetch('http://localhost:3001/payments', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ orderItems, services })
        })
            .then(response => response.text())
            .then(data => setStatus(data))
            .catch(error => console.error('Error processing payment:', error));
    };

    return (
        <div>
            <h1>Płatności</h1>
            <button onClick={handlePayment}>Zapłać teraz</button>
            <p>Status: {status}</p>
        </div>
    );
}

export default Payments;