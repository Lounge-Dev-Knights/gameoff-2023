import { addScore, getDailyScores } from "@/lib/score";
import { revalidatePath } from "next/cache";

export async function GET() {
  const scores = await getDailyScores();

  return Response.json(scores);
}

export async function POST(request: Request) {
  if (request.headers.get("x-api-key") !== process.env.API_KEY!) {
    return new Response("Unauthorized", { status: 401 });
  }

  const { score, name } = await request.json();

  await addScore(score, name);

  revalidatePath("/embed");

  return new Response("OK", { status: 201 });
}
