// Function to hide the loader and stop the countdown
function onStripeReady() {
    const counterLoader = document.getElementById('loading-container');
    if (counterLoader) {
        counterLoader.style.display = 'none';
    }
    clearInterval(window.countdownInterval);
}

const stripe = Stripe('pk_test_51Nfo0yAwqpCFthEvKId5qvHpXpCbLEUR6j6xwU52gzjWxXAUORKL3Lcb4v41pCWB0YXnt823SDxmMxSBPmWzF8zT00R8kA0RA4');

async function redirectToCheckout(successUrl, cancelUrl) {
    try {
        // Call your backend to create the checkout session
        const response = await fetch(baseUrlAppEngineFunctions + '/payments/create-checkout-session', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                success_url: successUrl,
                cancel_url: cancelUrl
            })
        });
        const session = await response.json();

        // If there's an error message in the session, log it
        if (session.error) {
            console.error(session.error);
            onStripeReady();
            return;
        }

        // Redirect to Stripe Checkout using the session ID
        const result = await stripe.redirectToCheckout({
            sessionId: session.id
        });

        if (result.error) {
            // If `redirectToCheckout` fails due to a browser or network error, display the error message
            console.error(result.error.message);
            onStripeReady();
        } else {
            // If no errors and redirection was successful, send a message to the Flutter web app
            window.parent.postMessage("Payment successful", "*");
        }
    } catch (error) {
        console.error("Error in redirectToCheckout:", error);
        onStripeReady();
    }
}

// Trigger the function when the page loads
redirectToCheckout('https://your-domain.com/payment-success', 'https://your-domain.com/payment-cancel');
