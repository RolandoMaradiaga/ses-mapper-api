# app/models/ses_record.rb
class SesRecord
  attr_reader :spam, :virus, :dns, :mes, :retrasado, :emisor, :receptor

  def initialize(data)
    ses = data["Records"].first["ses"]
    receipt = ses["receipt"]
    mail = ses["mail"]

    @spam = receipt["spamVerdict"]["status"] == "PASS"
    @virus = receipt["virusVerdict"]["status"] == "PASS"
    @dns = [ "spfVerdict", "dkimVerdict", "dmarcVerdict" ].all? { |key| receipt[key]["status"] == "PASS" }
    @mes = Date.parse(mail["timestamp"]).strftime("%B") # Converts to Month Name
    @retrasado = receipt["processingTimeMillis"].to_i > 1000
    @emisor = mail["source"].split("@").first
    @receptor = mail["destination"].map { |email| email.split("@").first }
  end

  def to_h
    {
      spam: @spam,
      virus: @virus,
      dns: @dns,
      mes: @mes,
      retrasado: @retrasado,
      emisor: @emisor,
      receptor: @receptor
    }
  end
end
