IMAGE_NAME="tshark_xxd_alpine"
docker build -t $IMAGE_NAME .

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <file_path.pcap>"
    exit 1
fi

INPUT_FILE=$1
FILE_NAME=$(basename "$INPUT_FILE")

# Ejecutar el contenedor y procesar el archivo
docker run --rm -v "$(dirname "$INPUT_FILE"):/data" $IMAGE_NAME \
    sh -c "tshark -r /data/$FILE_NAME -T fields -e data > /data/output.hex && \
           xxd -r -p /data/output.hex > /data/output.bin && \
           xxd /data/output.bin"
