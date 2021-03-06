
import java.util.Deque;
import java.util.LinkedList;


class Queue {
    double sum = 0;
    double sumVar = 0;
    double pClock = 0;
    int qMax = 0;
    private Deque<Entity> queue = new LinkedList<Entity>();

    public void add(Entity e) {
        queueChanged();
        queue.add(e);
        if (queue.size() > qMax)
            qMax = queue.size();
    }

    public void addPreEmpted(Entity e) // add in front of the queue
    {
        queueChanged();
        queue.addFirst(e);
        if (queue.size() > qMax)
            qMax = queue.size();
    }

    public Entity remove() {
        queueChanged();
        return queue.remove();
    }

    public boolean isEmpty() {
        return queue.isEmpty();
    }

    public int size() {
        return queue.size();
    }

    private void queueChanged() {
        sum += (Executer.clock - pClock) * queue.size();
        sumVar += (Executer.clock - pClock) * Math.pow(queue.size(), 2);
        pClock = Executer.clock;

    }

    public double queueMean() {
        double sum1 = sum + (Executer.simulationTime - pClock) * queue.size();//adjust the last change
        return (double) sum1 / Executer.simulationTime;
    }

    public double queueVar() {
        double sum1 = sumVar + (Executer.simulationTime - pClock) * Math.pow(queue.size(), 2);//adjust the last change
        return Math.sqrt(sum1 / Executer.simulationTime - Math.pow(queueMean(), 2));
    }

    public int queueMax() {
        return qMax;
    }
}

