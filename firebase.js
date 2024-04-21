import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
import {
    getFirestore,
    collection,
    doc,
    getDoc,
    getDocs,
    setDoc,
    query,
    where,
    updateDoc,
    Timestamp,
    limit,
  } from "firebase/firestore";
  
  import {
    getAuth,
    GoogleAuthProvider,
    onAuthStateChanged,
    signOut,
    signInWithPopup,
    signInWithEmailAndPassword,
    createUserWithEmailAndPassword,
    setPersistence,
    browserLocalPersistence,
  } from "firebase/auth";


const firebaseConfig = {
  apiKey: "AIzaSyAwyak_NjshuY-F6Myhni_zjgIiTSQY9xw",
  authDomain: "lahacks2024-18b32.firebaseapp.com",
  projectId: "lahacks2024-18b32",
  storageBucket: "lahacks2024-18b32.appspot.com",
  messagingSenderId: "427363153354",
  appId: "1:427363153354:web:aba8c459f68f395333cb33",
  measurementId: "G-0JDNNV1MJS"
};

// Initialize Firebase

const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);
const db = getFirestore(app);
const auth = getAuth(app);
const googleProvider = new GoogleAuthProvider();

export {
  auth,
  db,
  googleProvider,
  createUserWithEmailAndPassword,
  signInWithEmailAndPassword,
  signOut,
}