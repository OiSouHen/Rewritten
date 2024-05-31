function clamp(num, min, max) {
  return Math.min(Math.max(num, min), max);
}

function randomInteger(min, max) {
  const rand = min + Math.random() * (max + 1 - min);
  return Math.floor(rand);
}