const envEventMaxAgeMs = parseInt(String(process.env.EVENT_MAX_AGE_MS), 10);
const eventMaxAgeMs = isNaN(envEventMaxAgeMs) ? 30000 : envEventMaxAgeMs;

export { eventMaxAgeMs };
