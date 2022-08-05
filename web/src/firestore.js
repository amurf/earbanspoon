import { initializeApp } from "firebase/app";

import {
  getFirestore,
  collection,
  getDocs,
  connectFirestoreEmulator,
} from "firebase/firestore";

initializeApp({
  projectId: "demo-earbanspoon",
});

const db = getFirestore();
connectFirestoreEmulator(db, "localhost", 8080);

export async function getReviews() {
  const reviewsCollection = collection(db, "reviews");
  const reviewsSnapshot = await getDocs(reviewsCollection);
  const reviewsList = reviewsSnapshot.docs.map((doc) => doc.data());
  return reviewsList;
}
