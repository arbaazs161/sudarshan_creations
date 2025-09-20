/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */


const { onRequest, onCall } = require("firebase-functions/v2/https");
const { setGlobalOptions } = require("firebase-functions/v2");
const logger = require("firebase-functions/logger");
const functions = require('firebase-functions');
const admin = require('firebase-admin');
const nodemailer = require('nodemailer');


const {
    onDocumentCreated,
    // onDocumentCreated,
    // onDocumentUpdated,
    // onDocumentDeleted,
    // Change,
    // FirestoreEvent
} = require("firebase-functions/v2/firestore");
// For cost control, you can set the maximum number of containers that can be
// running at the same time. This helps mitigate the impact of unexpected
// traffic spikes by instead downgrading performance. This limit is a
// per-function limit. You can override the limit for each function using the
// `maxInstances` option in the function's options, e.g.
// `onRequest({ maxInstances: 5 }, (req, res) => { ... })`.
// NOTE: setGlobalOptions does not apply to functions using the v1 API. V1
// functions should each use functions.runWith({ maxInstances: 10 }) instead.
// In the v1 API, each function can only serve one request per container, so
// this will be the maximum concurrent request count.
setGlobalOptions({ maxInstances: 10 });

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });



var transporter = nodemailer.createTransport({
    host: 'smtp.gmail.com',
    port: 465,
    secure: true,
    auth: {
        user: 'teammetadc@gmail.com',
        pass: 'skfbnyjbyotmfvmw'
        // pass: 'zniorhjmhmatlzfd'
    }
});

admin.initializeApp();
const db = admin.firestore();

exports.sendOtpEmail = onCall(async (request) => {
    console.log('Sending...');
    console.log(request.data.email);
    const emailText = `<html>
    <body>
    <p>${request.data.otp} is your OTP. Valid for 5 minutes.</p>
    </body>
    </html>`;
    console.log('text created')
        ; sendEmailToUser(request.data.email, "Sudarshan-Cards-India", emailText);
    console.log('Sent...');

});

async function sendEmailToUser(to, subject, html) {
    try {
        const mailOptions = {
            from: {
                name: 'Sudarshan-Cards-India',
                address: 'teammetadc@gmail.com'
            },
            to: to,
            subject: subject,
            html: html
        };
        return transporter.sendMail(mailOptions, (error, data) => {
            if (error) {
                console.log(error)
                return
            }
            console.log("Sent!")
        });
    } catch (error) {
        console.log(error);
    }
}