import { addScore, getDailyScores } from "@/lib/score";
import { revalidatePath } from "next/cache";

const CORS_HEADERS = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
  "Access-Control-Allow-Headers": "Content-Type, x-api-key",
};

export function OPTIONS() {
  return new Response(null, { headers: CORS_HEADERS });
}

export async function GET() {
  const scores = await getDailyScores();

  return Response.json(scores, { headers: CORS_HEADERS });
}

export async function POST(request: Request) {
  if (request.headers.get("x-api-key") !== process.env.API_KEY!) {
    return new Response("Unauthorized", { status: 401, headers: CORS_HEADERS });
  }

  const { score, name } = await request.json();

  await addScore(score, name);

  revalidatePath("/embed");

  return new Response("OK", { status: 201, headers: CORS_HEADERS });
}
