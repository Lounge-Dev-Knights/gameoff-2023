import { getDailyScores } from "@/lib/score";
import { ImageResponse } from "next/og";

export async function GET() {
  const scores = await getDailyScores();

  return new ImageResponse(<div style={{
    display: 'flex',
    flexDirection: "column",
    width: "100%",
    gap: "8px",
    padding: "12px",
  }}>
    {scores.map((score) => (
      <div key={score.id} style={{
        display: "flex",
        flexDirection: "row",
        justifyContent: "space-between",
      }}>
        <div style={{ display: "flex" }}>{score.score}</div>
        <div style={{ display: "flex" }}>{score.name}</div>
      </div>
    ))}
  </div>, {
    width: 512,
    height: 512,
  })
}
