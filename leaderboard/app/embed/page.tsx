import { getDailyScores } from "@/lib/score";

export default async function Page() {
  const scores = await getDailyScores();

  return (
    <main className="p-4">
      <table className="w-full">
        <thead>
          <tr>
            <th className="text-left font-normal text-slate-500">Score</th>
            <th className="text-right font-normal text-slate-500">Name</th>
          </tr>
        </thead>
        <tbody>
          {scores.map((score) => (
            <tr key={score.id}>
              <td className="text-slate-950">{score.score}</td>
              <td className="text-right text-slate-950">{score.name}</td>
            </tr>
          ))}
        </tbody>
        <tfoot>
          <tr><td colSpan={2} className="text-right text-slate-500 font-light">Scores reset at 00:00 UTC</td></tr>
        </tfoot>
      </table>
    </main>
  );
}
